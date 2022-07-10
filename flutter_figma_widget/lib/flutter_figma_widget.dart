library flutter_figma_widget;

export 'src/widgets/component.dart';
export 'src/widgets/data_provider.dart';

export 'src/generators/component.dart';

export 'package:figma_widget_parser/figma_widget_parser.dart'
    show
        parseFigmaWidget,
        Component,
        Result,
        formatFigmaWidgetSource,
        FormattedSource,
        FormattedToken,
        FormattedTokenType;
