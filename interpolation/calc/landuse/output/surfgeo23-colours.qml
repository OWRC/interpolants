<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis styleCategories="AllStyleCategories" hasScaleBasedVisibilityFlag="0" maxScale="0" version="3.28.8-Firenze" minScale="1e+08">
  <flags>
    <Identifiable>1</Identifiable>
    <Removable>1</Removable>
    <Searchable>1</Searchable>
    <Private>0</Private>
  </flags>
  <temporal fetchMode="0" mode="0" enabled="0">
    <fixedRange>
      <start></start>
      <end></end>
    </fixedRange>
  </temporal>
  <elevation band="1" zoffset="0" zscale="1" symbology="Line" enabled="0">
    <data-defined-properties>
      <Option type="Map">
        <Option value="" name="name" type="QString"/>
        <Option name="properties"/>
        <Option value="collection" name="type" type="QString"/>
      </Option>
    </data-defined-properties>
    <profileLineSymbol>
      <symbol force_rhr="0" name="" frame_rate="10" alpha="1" clip_to_extent="1" type="line" is_animated="0">
        <data_defined_properties>
          <Option type="Map">
            <Option value="" name="name" type="QString"/>
            <Option name="properties"/>
            <Option value="collection" name="type" type="QString"/>
          </Option>
        </data_defined_properties>
        <layer class="SimpleLine" locked="0" enabled="1" pass="0">
          <Option type="Map">
            <Option value="0" name="align_dash_pattern" type="QString"/>
            <Option value="square" name="capstyle" type="QString"/>
            <Option value="5;2" name="customdash" type="QString"/>
            <Option value="3x:0,0,0,0,0,0" name="customdash_map_unit_scale" type="QString"/>
            <Option value="MM" name="customdash_unit" type="QString"/>
            <Option value="0" name="dash_pattern_offset" type="QString"/>
            <Option value="3x:0,0,0,0,0,0" name="dash_pattern_offset_map_unit_scale" type="QString"/>
            <Option value="MM" name="dash_pattern_offset_unit" type="QString"/>
            <Option value="0" name="draw_inside_polygon" type="QString"/>
            <Option value="bevel" name="joinstyle" type="QString"/>
            <Option value="255,158,23,255" name="line_color" type="QString"/>
            <Option value="solid" name="line_style" type="QString"/>
            <Option value="0.6" name="line_width" type="QString"/>
            <Option value="MM" name="line_width_unit" type="QString"/>
            <Option value="0" name="offset" type="QString"/>
            <Option value="3x:0,0,0,0,0,0" name="offset_map_unit_scale" type="QString"/>
            <Option value="MM" name="offset_unit" type="QString"/>
            <Option value="0" name="ring_filter" type="QString"/>
            <Option value="0" name="trim_distance_end" type="QString"/>
            <Option value="3x:0,0,0,0,0,0" name="trim_distance_end_map_unit_scale" type="QString"/>
            <Option value="MM" name="trim_distance_end_unit" type="QString"/>
            <Option value="0" name="trim_distance_start" type="QString"/>
            <Option value="3x:0,0,0,0,0,0" name="trim_distance_start_map_unit_scale" type="QString"/>
            <Option value="MM" name="trim_distance_start_unit" type="QString"/>
            <Option value="0" name="tweak_dash_pattern_on_corners" type="QString"/>
            <Option value="0" name="use_custom_dash" type="QString"/>
            <Option value="3x:0,0,0,0,0,0" name="width_map_unit_scale" type="QString"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" name="name" type="QString"/>
              <Option name="properties"/>
              <Option value="collection" name="type" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </profileLineSymbol>
    <profileFillSymbol>
      <symbol force_rhr="0" name="" frame_rate="10" alpha="1" clip_to_extent="1" type="fill" is_animated="0">
        <data_defined_properties>
          <Option type="Map">
            <Option value="" name="name" type="QString"/>
            <Option name="properties"/>
            <Option value="collection" name="type" type="QString"/>
          </Option>
        </data_defined_properties>
        <layer class="SimpleFill" locked="0" enabled="1" pass="0">
          <Option type="Map">
            <Option value="3x:0,0,0,0,0,0" name="border_width_map_unit_scale" type="QString"/>
            <Option value="255,158,23,255" name="color" type="QString"/>
            <Option value="bevel" name="joinstyle" type="QString"/>
            <Option value="0,0" name="offset" type="QString"/>
            <Option value="3x:0,0,0,0,0,0" name="offset_map_unit_scale" type="QString"/>
            <Option value="MM" name="offset_unit" type="QString"/>
            <Option value="35,35,35,255" name="outline_color" type="QString"/>
            <Option value="no" name="outline_style" type="QString"/>
            <Option value="0.26" name="outline_width" type="QString"/>
            <Option value="MM" name="outline_width_unit" type="QString"/>
            <Option value="solid" name="style" type="QString"/>
          </Option>
          <data_defined_properties>
            <Option type="Map">
              <Option value="" name="name" type="QString"/>
              <Option name="properties"/>
              <Option value="collection" name="type" type="QString"/>
            </Option>
          </data_defined_properties>
        </layer>
      </symbol>
    </profileFillSymbol>
  </elevation>
  <customproperties>
    <Option type="Map">
      <Option value="false" name="WMSBackgroundLayer" type="bool"/>
      <Option value="false" name="WMSPublishDataSourceUrl" type="bool"/>
      <Option value="0" name="embeddedWidgets/count" type="int"/>
      <Option value="Value" name="identify/format" type="QString"/>
    </Option>
  </customproperties>
  <pipe-data-defined-properties>
    <Option type="Map">
      <Option value="" name="name" type="QString"/>
      <Option name="properties"/>
      <Option value="collection" name="type" type="QString"/>
    </Option>
  </pipe-data-defined-properties>
  <pipe>
    <provider>
      <resampling zoomedInResamplingMethod="nearestNeighbour" zoomedOutResamplingMethod="nearestNeighbour" enabled="false" maxOversampling="2"/>
    </provider>
    <rasterrenderer band="1" alphaBand="-1" opacity="1" type="paletted" nodataColor="">
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
        <paletteEntry value="0" color="#0172fe" alpha="255" label="Waterbody"/>
        <paletteEntry value="10" color="#ff7e7e" alpha="255" label="Precambrian bedrock"/>
        <paletteEntry value="20" color="#ff7e7e" alpha="255" label="Bedrock-drift complex in Precambrian terrain"/>
        <paletteEntry value="21" color="#ff7e7e" alpha="255" label="Bedrock-drift complex in Precambrian terrain: Primarily till cover"/>
        <paletteEntry value="22" color="#ff7e7e" alpha="255" label="Bedrock-drift complex in Precambrian terrain: Primarily stratified drift cover"/>
        <paletteEntry value="30" color="#ca79f5" alpha="255" label="Sedimentary (Paleozoic) bedrock"/>
        <paletteEntry value="40" color="#ca79f5" alpha="255" label="Bedrock-drift complex in Paleozoic terrain"/>
        <paletteEntry value="41" color="#ca79f5" alpha="255" label="Bedrock-drift complex in Paleozoic terrain: Primarily till cover"/>
        <paletteEntry value="50" color="#6fa800" alpha="255" label="Till (Diamicton)"/>
        <paletteEntry value="51" color="#a3fda0" alpha="255" label="Till: Silty sand to sand-textured till on Precambrian terrain"/>
        <paletteEntry value="52" color="#87be00" alpha="255" label="Till: Stone-poor, sandy silt to silty sand-textured till on Paleozoic terrain"/>
        <paletteEntry value="53" color="#b4fd00" alpha="255" label="Till: Stony, sandy silt to silty sand-textured till on Paleozoic terrain"/>
        <paletteEntry value="54" color="#059500" alpha="255" label="Till: Clay to silt-textured till (derived from glaciolacustrine deposits or shale)"/>
        <paletteEntry value="55" color="#018100" alpha="255" label="Till: Undifferentiated older tills, may include stratified deposits"/>
        <paletteEntry value="60" color="#ffaa00" alpha="255" label="Ice-contact stratified deposits"/>
        <paletteEntry value="61" color="#ffaa00" alpha="255" label="Ice-contact stratified deposits: In moraines, eskers, kames and crevasse fills"/>
        <paletteEntry value="62" color="#ffaa00" alpha="255" label="Ice-contact stratified deposits: In subaquatic fans"/>
        <paletteEntry value="70" color="#fdd77c" alpha="255" label="Glaciofluvial deposits: Sandy deposits"/>
        <paletteEntry value="71" color="#fdd77c" alpha="255" label="Glaciofluvial deposits: Gravelly deposits"/>
        <paletteEntry value="72" color="#fdd77c" alpha="255" label="Glaciofluvial deposits"/>
        <paletteEntry value="80" color="#a4f9fd" alpha="255" label="Fine-textured glaciolacustrine deposits"/>
        <paletteEntry value="81" color="#a4f9fd" alpha="255" label="Fine-textured glaciolacustrine deposits: Massive to well laminated"/>
        <paletteEntry value="82" color="#a4f9fd" alpha="255" label="Fine-textured glaciolacustrine deposits: Interbedded silt and clay and gritty, pebbly flow till and rainout deposits"/>
        <paletteEntry value="90" color="#ffff00" alpha="255" label="Coarse-textured glaciolacustrine deposits"/>
        <paletteEntry value="91" color="#ffff00" alpha="255" label="Coarse-textured glaciolacustrine deposits: Deltaic deposits"/>
        <paletteEntry value="92" color="#ffff00" alpha="255" label="Coarse-textured glaciolacustrine deposits: Littoral deposits"/>
        <paletteEntry value="93" color="#ffff00" alpha="255" label="Coarse-textured glaciolacustrine deposits: Foreshore and basinal deposits"/>
        <paletteEntry value="120" color="#a06531" alpha="255" label="Older alluvial deposits"/>
        <paletteEntry value="130" color="#13a4ab" alpha="255" label="Fine-textured lacustrine deposits"/>
        <paletteEntry value="140" color="#ffff00" alpha="255" label="Coarse-textured lacustrine deposits"/>
        <paletteEntry value="142" color="#ffff00" alpha="255" label="Coarse-textured lacustrine deposits: Littoral deposits"/>
        <paletteEntry value="143" color="#ffff00" alpha="255" label="Coarse-textured lacustrine deposits: Foreshore and basinal deposits"/>
        <paletteEntry value="170" color="#fdf9c2" alpha="255" label="Eolian deposits"/>
        <paletteEntry value="190" color="#a06531" alpha="255" label="Modern alluvial deposits"/>
        <paletteEntry value="200" color="#9c9c9c" alpha="255" label="Organic Deposits"/>
        <paletteEntry value="210" color="#a900e6" alpha="255" label="Fill"/>
      </colorPalette>
      <colorramp name="[source]" type="randomcolors">
        <Option/>
      </colorramp>
    </rasterrenderer>
    <brightnesscontrast contrast="0" gamma="1" brightness="0"/>
    <huesaturation saturation="0" grayscaleMode="0" colorizeBlue="128" colorizeStrength="100" colorizeOn="0" colorizeGreen="128" invertColors="0" colorizeRed="255"/>
    <rasterresampler maxOversampling="2"/>
    <resamplingStage>resamplingFilter</resamplingStage>
  </pipe>
  <blendMode>0</blendMode>
</qgis>
