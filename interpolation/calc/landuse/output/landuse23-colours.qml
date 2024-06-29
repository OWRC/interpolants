<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis hasScaleBasedVisibilityFlag="0" maxScale="0" styleCategories="AllStyleCategories" minScale="1e+08" version="3.28.8-Firenze">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <temporal fetchMode="0" enabled="0" mode="0">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <elevation zoffset="0" band="1" symbology="Line" enabled="0" zscale="1">
    <data-defined-properties>
      <Option type="Map">
        <Option type="QString" value="" name="name"/>
        <Option name="properties"/>
        <Option type="QString" value="collection" name="type"/>
      </Option>
    </data-defined-properties>
    <profileLineSymbol>
      <symbol type="line" frame_rate="10" clip_to_extent="1" is_animated="0" force_rhr="0" name="" alpha="1">
        <data_defined_properties>
          <Option type="Map">
            <Option type="QString" value="" name="name"/>
            <Option name="properties"/>
            <Option type="QString" value="collection" name="type"/>
          </Option>
        </data_defined_properties>
        <layer class="SimpleLine" locked="0" pass="0" enabled="1">
          <Option type="Map">
            <Option type="QString" value="0" name="align_dash_pattern"/>
            <Option type="QString" value="square" name="capstyle"/>
            <Option type="QString" value="5;2" name="customdash"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="customdash_map_unit_scale"/>
            <Option type="QString" value="MM" name="customdash_unit"/>
            <Option type="QString" value="0" name="dash_pattern_offset"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="dash_pattern_offset_map_unit_scale"/>
            <Option type="QString" value="MM" name="dash_pattern_offset_unit"/>
            <Option type="QString" value="0" name="draw_inside_polygon"/>
            <Option type="QString" value="bevel" name="joinstyle"/>
            <Option type="QString" value="255,158,23,255" name="line_color"/>
            <Option type="QString" value="solid" name="line_style"/>
            <Option type="QString" value="0.6" name="line_width"/>
            <Option type="QString" value="MM" name="line_width_unit"/>
            <Option type="QString" value="0" name="offset"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
            <Option type="QString" value="MM" name="offset_unit"/>
            <Option type="QString" value="0" name="ring_filter"/>
            <Option type="QString" value="0" name="trim_distance_end"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="trim_distance_end_map_unit_scale"/>
            <Option type="QString" value="MM" name="trim_distance_end_unit"/>
            <Option type="QString" value="0" name="trim_distance_start"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="trim_distance_start_map_unit_scale"/>
            <Option type="QString" value="MM" name="trim_distance_start_unit"/>
            <Option type="QString" value="0" name="tweak_dash_pattern_on_corners"/>
            <Option type="QString" value="0" name="use_custom_dash"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="width_map_unit_scale"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option name="properties"/>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </profileLineSymbol>
    <profileFillSymbol>
      <symbol type="fill" frame_rate="10" clip_to_extent="1" is_animated="0" force_rhr="0" name="" alpha="1">
        <data_defined_properties>
          <Option type="Map">
            <Option type="QString" value="" name="name"/>
            <Option name="properties"/>
            <Option type="QString" value="collection" name="type"/>
          </Option>
        </data_defined_properties>
        <layer class="SimpleFill" locked="0" pass="0" enabled="1">
          <Option type="Map">
            <Option type="QString" value="3x:0,0,0,0,0,0" name="border_width_map_unit_scale"/>
            <Option type="QString" value="255,158,23,255" name="color"/>
            <Option type="QString" value="bevel" name="joinstyle"/>
            <Option type="QString" value="0,0" name="offset"/>
            <Option type="QString" value="3x:0,0,0,0,0,0" name="offset_map_unit_scale"/>
            <Option type="QString" value="MM" name="offset_unit"/>
            <Option type="QString" value="35,35,35,255" name="outline_color"/>
            <Option type="QString" value="no" name="outline_style"/>
            <Option type="QString" value="0.26" name="outline_width"/>
            <Option type="QString" value="MM" name="outline_width_unit"/>
            <Option type="QString" value="solid" name="style"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option type="QString" value="" name="name"/>
              <Option name="properties"/>
              <Option type="QString" value="collection" name="type"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </profileFillSymbol>
  </elevation>
  <customproperties>
    <Option type="Map">
      <Option type="bool" value="false" name="WMSBackgroundLayer"/>
      <Option type="bool" value="false" name="WMSPublishDataSourceUrl"/>
      <Option type="int" value="0" name="embeddedWidgets/count"/>
      <Option type="QString" value="Value" name="identify/format"/>
    </Option>
  </customproperties>
  <pipe-data-defined-properties>
    <Option type="Map">
      <Option type="QString" value="" name="name"/>
      <Option name="properties"/>
      <Option type="QString" value="collection" name="type"/>
    </Option>
  </pipe-data-defined-properties>
  <pipe>
    <provider>
      <resampling zoomedOutResamplingMethod="nearestNeighbour" maxOversampling="2" zoomedInResamplingMethod="nearestNeighbour" enabled="false"/>
    </provider>
    <rasterrenderer nodataColor="" type="paletted" alphaBand="-1" band="1" opacity="1">
      <rasterTransparency/>
      <minMaxOrigin>
        <limits>None</limits>
        <extent>WholeRaster</extent>
        <statAccuracy>Estimated</statAccuracy>
        <cumulativeCutLower>0.02</cumulativeCutLower>
        <cumulativeCutUpper>0.98</cumulativeCutUpper>
        <stdDevFactor>2</stdDevFactor>
      </minMaxOrigin>
      <colorPalette>
        <paletteEntry label="Open Beach/Bar" value="11" alpha="255" color="#ffff14"/>
        <paletteEntry label="Open Sand Dune" value="21" alpha="255" color="#ffd15e"/>
        <paletteEntry label="Treed Sand Dune" value="23" alpha="255" color="#d6ab00"/>
        <paletteEntry label="Open Cliff and Talus" value="41" alpha="255" color="#9eab00"/>
        <paletteEntry label="Treed Cliff and Talus" value="43" alpha="255" color="#9eab00"/>
        <paletteEntry label="Shrub Alvar" value="52" alpha="255" color="#d7c29e"/>
        <paletteEntry label="Treed Alvar" value="53" alpha="255" color="#d7c29e"/>
        <paletteEntry label="Open Bedrock" value="64" alpha="255" color="#b3afa4"/>
        <paletteEntry label="Sparse Treed" value="65" alpha="255" color="#9dbf30"/>
        <paletteEntry label="Open Tallgrass Prairie" value="81" alpha="255" color="#4da678"/>
        <paletteEntry label="Tallgrass Savannah" value="82" alpha="255" color="#40ff00"/>
        <paletteEntry label="Tallgrass Woodland" value="83" alpha="255" color="#78fa4d"/>
        <paletteEntry label="Forest" value="90" alpha="255" color="#75bf30"/>
        <paletteEntry label="Coniferous Forest" value="91" alpha="255" color="#08541c"/>
        <paletteEntry label="Mixed Forest" value="92" alpha="255" color="#057a52"/>
        <paletteEntry label="Deciduous Forest" value="93" alpha="255" color="#66962e"/>
        <paletteEntry label="Treed Swamp" value="131" alpha="255" color="#9945d6"/>
        <paletteEntry label="Thicket Swamp" value="135" alpha="255" color="#9945d6"/>
        <paletteEntry label="Fen" value="140" alpha="255" color="#ed9cbd"/>
        <paletteEntry label="Bog" value="150" alpha="255" color="#bf7083"/>
        <paletteEntry label="Marsh" value="160" alpha="255" color="#ad96d6"/>
        <paletteEntry label="Open Water" value="170" alpha="255" color="#0000ff"/>
        <paletteEntry label="Plantations – Tree Cultivated" value="191" alpha="255" color="#59b061"/>
        <paletteEntry label="Hedge Rows" value="192" alpha="255" color="#45ba21"/>
        <paletteEntry label="Tilled" value="193" alpha="255" color="#b3afa4"/>
        <paletteEntry label="Transportation" value="201" alpha="255" color="#ff0000"/>
        <paletteEntry label="Built-Up Area – Pervious" value="202" alpha="255" color="#abcf3d"/>
        <paletteEntry label="Built-Up Area – Impervious" value="203" alpha="255" color="#c4c2c7"/>
        <paletteEntry label="Extraction – Aggregate" value="204" alpha="255" color="#e67e8c"/>
        <paletteEntry label="Extraction – Peat/Topsoil" value="205" alpha="255" color="#e67e8c"/>
        <paletteEntry label="Undifferentiated" value="250" alpha="255" color="#b3afa4"/>
      </colorPalette>
      <colorramp type="randomcolors" name="[source]">
        <Option/>
      </colorramp>
    </rasterrenderer>
    <brightnesscontrast brightness="0" gamma="1" contrast="0"/>
    <huesaturation invertColors="0" colorizeGreen="128" saturation="0" colorizeStrength="100" colorizeBlue="128" grayscaleMode="0" colorizeRed="255" colorizeOn="0"/>
    <rasterresampler maxOversampling="2"/>
    <resamplingStage>resamplingFilter</resamplingStage>
  </pipe>
  <blendMode>0</blendMode>
</qgis>
