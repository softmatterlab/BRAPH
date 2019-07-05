% File to test the use of MRIRandomComparisonWU.
%
% See also MRIRandomComparisonWU.

% Author: Mite Mijalkov, Ehsan Kakaei & Giovanni Volpe
% Date: 2016/01/01

close all
clear all
clc

%% Create BrainAtlas from BrainRegion list

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

brs = {br1 br2 br3 br4 br5};
atlas = BrainAtlas(brs,BrainAtlas.NAME,'Atlas1');

%% create subjects

sub1 = MRISubject( ...
    MRISubject.CODE,'SUB1', ...
    MRISubject.AGE,71, ...
    MRISubject.GENDER,MRISubject.GENDER_FEMALE, ...
    MRISubject.DATA,rand(1,atlas.length()), ...
    MRISubject.NOTES,'none 1');

sub2 = MRISubject( ...
    MRISubject.CODE,'SUB2', ...
    MRISubject.AGE,72, ...
    MRISubject.GENDER,MRISubject.GENDER_MALE, ...
    MRISubject.DATA,rand(1,atlas.length()), ...
    MRISubject.NOTES,'none 2');

sub3 = MRISubject( ...
    MRISubject.CODE,'SUB3', ...
    MRISubject.AGE,73, ...
    MRISubject.GENDER,MRISubject.GENDER_FEMALE, ...
    MRISubject.DATA,rand(1,atlas.length()), ...
    MRISubject.NOTES,'none 3');

sub = {sub3 sub2 sub1};

%% create cohort

cohort = MRICohort(atlas,sub,MRICohort.NAME,'Cohort Trial');

%% create WU random comparison

comparison = MRIRandomComparisonWU( ...
    MRIComparisonWU.CODE,3, ...
    MRIComparisonWU.NOTES,'Comparison WU', ...
    MRIComparisonWU.GROUP1,1)

%% hash, isMeasure, isComparison

[code,g,d] = comparison.hash();
bool1 = comparison.isMeasure()
bool2 = comparison.isComparison()
bool3 = comparison.isRandom()

%% getTags, getFormats

tags = comparison.getTags()
formats = comparison.getFormats()
 