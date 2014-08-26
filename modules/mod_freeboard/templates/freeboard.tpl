<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>freeboard</title>
    <meta name="apple-mobile-web-app-capable" content="yes" />
    <meta name="apple-mobile-web-app-status-bar-style" content="black" />
    <meta name="viewport" content = "width = device-width, initial-scale = 1, user-scalable = no" />
    
    {% lib 
        "css/jquery.gridster.min.css" 
        "css/styles.css" 
    %}
    {% include "_js_include_jquery.tpl" %}
    {% lib 
        "js/knockout.js"
        "js/underscore.js"
        "js/jquery.gridster.js"
        "js/jquery.sparkline.min.js"
        "js/jquery.caret.js"
        "js/raphael.2.1.0.min.js"
        "js/justgage.1.0.1.js"
        "js/freeboard/freeboard.js"
        "js/freeboard/plugins/freeboard.datasources.js"
        "js/freeboard/plugins/freeboard.widgets.js"
        "examples/plugin_example.js"
    %}
    <script type="text/javascript">
        // *** Load more plugins here ***
        $(function() { //DOM Ready
            freeboard.initialize(true);
        });
    </script>
</head>
<body>
<div id="board-content">
    <img id="dash-logo" data-bind="attr:{src: header_image}, visible:header_image()">
    <div class="gridster">
        <ul data-bind="grid: true">
        </ul>
    </div>
</div>
<header id="main-header" data-bind="if:allow_edit">
    <div id="admin-bar">
        <div id="admin-menu">
            <div id="board-tools">
                <h1 id="board-logo" class="title bordered">freeboard</h1>
                <div id="board-actions">
                    <ul class="board-toolbar vertical">
                        <li data-bind="click: loadDashboardFromLocalFile"><i id="full-screen-icon" class="icon-folder-open icon-white"></i><label id="full-screen">Load Freeboard</label></li>
                        <li data-bind="click: saveDashboard"><i class="icon-download-alt icon-white"></i><label>Save Freeboard</label></li>
                        <li id="add-pane" data-bind="click: createPane"><i class="icon-plus icon-white"></i><label>Add Pane</label></li>
                    </ul>
                </div>
            </div>
            <div id="datasources">
                <h2 class="title">DATASOURCES</h2>

                <div class="datasource-list-container">
                    <table class="table table-condensed sub-table" id="datasources-list" data-bind="if: datasources().length">
                        <thead>
                        <tr>
                            <th>Name</th>
                            <th>Last Updated</th>
                            <th>&nbsp;</th>
                        </tr>
                        </thead>
                        <tbody data-bind="foreach: datasources">
                        <tr>
                            <td>
                                <span class="text-button datasource-name" data-bind="text: name, pluginEditor: {operation: 'edit', type: 'datasource'}"></span>
                            </td>
                            <td data-bind="text: last_updated"></td>
                            <td>
                                <ul class="board-toolbar">
                                    <li data-bind="click: updateNow"><i class="icon-refresh icon-white"></i></li>
                                    <li data-bind="pluginEditor: {operation: 'delete', type: 'datasource'}">
                                        <i class="icon-trash icon-white"></i></li>
                                </ul>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <span class="text-button table-operation" data-bind="pluginEditor: {operation: 'add', type: 'datasource'}">ADD</span>
            </div>
        </div>
    </div>
    <div id="toggle-header" data-bind="click: toggleEditing">
        <i id="toggle-header-icon" class="icon-wrench icon-white"></i></div>
</header>

<div style="display:hidden">
    <ul data-bind="template: { name: 'pane-template', foreach: panes}">
    </ul>
</div>

<script type="text/html" id="pane-template">
    <li data-bind="pane: true">
        <header>
            <h1 data-bind="text: title"></h1>
            <ul class="board-toolbar pane-tools">
                <li data-bind="pluginEditor: {operation: 'add', type: 'widget'}">
                    <i class="icon-plus icon-white"></i>
                </li>
                <li data-bind="pluginEditor: {operation: 'edit', type: 'pane'}">
                    <i class="icon-wrench icon-white"></i>
                </li>
                <li data-bind="pluginEditor: {operation: 'delete', type: 'pane'}">
                    <i class="icon-trash icon-white"></i>
                </li>
            </ul>
        </header>
        <section data-bind="foreach: widgets">
            <div class="sub-section" data-bind="css: 'sub-section-height-' + height()">
                <div class="widget" data-bind="widget: true, css:{fillsize:fillSize}"></div>
                <div class="sub-section-tools">
                    <ul class="board-toolbar">
                        <!-- ko if:$parent.widgetCanMoveUp($data) -->
                        <li data-bind="click:$parent.moveWidgetUp"><i class="icon-chevron-up icon-white"></i></li>
                        <!-- /ko -->
                        <!-- ko if:$parent.widgetCanMoveDown($data) -->
                        <li data-bind="click:$parent.moveWidgetDown"><i class="icon-chevron-down icon-white"></i></li>
                        <!-- /ko -->
                        <li data-bind="pluginEditor: {operation: 'edit', type: 'widget'}"><i class="icon-wrench icon-white"></i></li>
                        <li data-bind="pluginEditor: {operation: 'delete', type: 'widget'}"><i class="icon-trash icon-white"></i></li>
                    </ul>
                </div>
            </div>
        </section>
    </li>
</script>

</body>
</html>
