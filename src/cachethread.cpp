/*
 * This file is part of BeamerPresenter.
 * Copyright (C) 2019  stiglers-eponym

 * BeamerPresenter is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.

 * BeamerPresenter is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.

 * You should have received a copy of the GNU General Public License
 * along with BeamerPresenter. If not, see <https://www.gnu.org/licenses/>.
 */

#include "cachethread.h"


void CacheThread::run()
{
    QString renderCommand = cacheMap->getRenderCommand(page);
    if (renderCommand.isEmpty()) {
        QPixmap pixmap = cacheMap->renderPixmap(page);
        if (isInterruptionRequested())
            return;
        QByteArray* bytes = new QByteArray();
        QBuffer buffer(bytes);
        buffer.open(QIODevice::WriteOnly);
        pixmap.save(&buffer, "PNG");
        if (isInterruptionRequested())
            delete bytes;
        else
            emit resultsReady(page, bytes);
    }
    else {
        ExternalRenderer* renderer = new ExternalRenderer(page);
        renderer->start(renderCommand);
        QByteArray const* bytes = nullptr;
        if (renderer->waitForFinished(60000))
            bytes = renderer->getBytes();
        else
            renderer->kill();
        delete renderer;
        if (isInterruptionRequested()) {
            delete bytes;
            return;
        }
        if (cacheMap->getPagePart() != FullPage) {
            QPixmap pixmap;
            pixmap.loadFromData(*bytes, "PNG");
            delete bytes;
            if (cacheMap->getPagePart() == LeftHalf)
                pixmap = pixmap.copy(0, 0, pixmap.width()/2, pixmap.height());
            else
                pixmap = pixmap.copy(pixmap.width()/2, 0, pixmap.width()/2, pixmap.height());
            QByteArray* bytes = new QByteArray();
            QBuffer buffer(bytes);
            buffer.open(QIODevice::WriteOnly);
            pixmap.save(&buffer, "PNG");
            if (isInterruptionRequested()) {
                delete bytes;
                return;
            }
        }
        emit resultsReady(page, bytes);
    }
}