% File to test the use of BrainRegion.
%
% See also BrainRegion, ListElement.

% Author: Mite Mijalkov, Ehsan Kakaei & Giovanni Volpe
% Date: 2016/01/01

close all
clear all
clc

%% Create 5 Brain Regions
br1 = BrainRegion(BrainRegion.LABEL,'REG. 1', ...
    BrainRegion.NAME,'Brain Region 1', ...
    BrainRegion.X,1, ...
    BrainRegion.Y,1, ...
    BrainRegion.Z,1, ...
    BrainRegion.HS,BrainRegion.HS_LEFT, ...
    BrainRegion.NOTES,'notes1 ...');

br2 = BrainRegion(BrainRegion.LABEL,'REG. 2', ...
    BrainRegion.NAME,'Brain Region 2', ...
    BrainRegion.X,2, ...
    BrainRegion.Y,-2, ...
    BrainRegion.Z,2, ...
    BrainRegion.HS,BrainRegion.HS_RIGHT, ...
    BrainRegion.NOTES,'notes2 ...');

br3 = BrainRegion(BrainRegion.LABEL,'REG. 3', ...
    BrainRegion.NAME,'Brain Region 3', ...
    BrainRegion.X,3, ...
    BrainRegion.Y,3, ...
    BrainRegion.Z,-3, ...
    BrainRegion.HS,BrainRegion.HS_LEFT, ...
    BrainRegion.NOTES,'notes3 ...');

br4 = BrainRegion(BrainRegion.LABEL,'REG. 4', ...
    BrainRegion.NAME,'Brain Region 4', ...
    BrainRegion.X,-4, ...
    BrainRegion.Y,4, ...
    BrainRegion.Z,4, ...
    BrainRegion.HS,BrainRegion.HS_RIGHT, ...
    BrainRegion.NOTES,'notes4 ...');

br5 = BrainRegion(BrainRegion.LABEL,'REG. 5', ...
    BrainRegion.NAME,'Brain Region 5', ...
    BrainRegion.X,-5, ...
    BrainRegion.Y,-5, ...
    BrainRegion.Z,5, ...
    BrainRegion.HS,BrainRegion.HS_LEFT, ...
    BrainRegion.NOTES,'notes5 ...');

%% disp

br1.disp()  % display a brain region

%% getProp and setProp methods

[value1,format1,tag1] = br3.getProp(br3.X)  % get all properties of br3.X
[value2,format2,tag2] = br3.getProp(br3.NOTES)

br3.setProp(br3.X,-3)  % set value of br3.X to -3
br3.setProp(br3.NOTES,'updated notes3 ....')

[value_new1,format_new1,tag_new1] = br3.getProp(br3.X)  % get new property of br3.X
[value_new2,format_new2,tag_new2] = br3.getProp(br3.NOTES)

%% getPropValue, getPropFormat, getPropTag

value = br5.getPropValue(br5.Z)  % get value of br5.Z
format = br5.getPropFormat(br5.Z)  % get format of br5.Z
tag = br5.getPropTag(br5.Z)  % get tag of br5.Z

%% save and load from XML
Document = com.mathworks.xml.XMLUtils.createDocument('xml');
RootNode = Document.getDocumentElement;
ElementNode = br4.toXML(Document,RootNode);
br4 = xmlwrite(Document)

br6 = BrainRegion();
fromXML(br6,ElementNode)

%% clear and copy
br6 = br5.copy()
br5.clear()

br5
br6