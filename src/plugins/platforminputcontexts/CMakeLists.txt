# Copyright (C) 2022 The Qt Company Ltd.
# SPDX-License-Identifier: BSD-3-Clause

if(QT_FEATURE_xkbcommon)
    add_subdirectory(compose)
endif()
if(QT_FEATURE_xkbcommon AND TARGET Qt::DBus AND (UNIX OR WASI) AND NOT MACOS)
    add_subdirectory(ibus)
endif()
