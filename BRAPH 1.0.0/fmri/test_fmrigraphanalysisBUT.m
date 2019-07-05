% File to test the use of fMRIGraphAnalysisBUT.
%
% See also fMRIGraphAnalysisBUT.

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

%% creating subects, groups and cohort

sub1 = fMRISubject( ...
    fMRISubject.CODE,'SUB1', ...
    fMRISubject.AGE,75, ...
    fMRISubject.GENDER,fMRISubject.GENDER_FEMALE, ...
    fMRISubject.DATA,10*rand(length(atlas)), ...
    fMRISubject.NOTES,'none');

sub2 = fMRISubject( ...
    fMRISubject.CODE,'SUB1', ...
    fMRISubject.AGE,75, ...
    fMRISubject.GENDER,fMRISubject.GENDER_FEMALE, ...
    fMRISubject.DATA,10*rand(length(atlas)), ...
    fMRISubject.NOTES,'none');

sub3 = fMRISubject( ...
    fMRISubject.CODE,'SUB1', ...
    fMRISubject.AGE,75, ...
    fMRISubject.GENDER,fMRISubject.GENDER_FEMALE, ...
    fMRISubject.DATA,10*rand(length(atlas)), ...
    fMRISubject.NOTES,'none');

sub4 = fMRISubject( ...
    fMRISubject.CODE,'SUB1', ...
    fMRISubject.AGE,75, ...
    fMRISubject.GENDER,fMRISubject.GENDER_FEMALE, ...
    fMRISubject.DATA,10*rand(length(atlas)), ...
    fMRISubject.NOTES,'none');

subjects = {sub1 sub2 sub3 sub4};

cohort = fMRICohort(atlas,subjects);

g1 = Group( ...
    Group.NAME,'gr1', ...
    Group.DATA,[1 1 0 0], ...
    Group.NOTES,'notes gr 1');
g2 = Group( ...
    Group.NAME,'gr2', ...
    Group.DATA,[0 0 1 1], ...
    Group.NOTES,'notes gr 2');
cohort.addgroup(g1)  % add group g1 to cohort
cohort.addgroup(g2)  % add group g2 to cohort

%% Graph analysis BUT, calculate, compare

gaBUT = fMRIGraphAnalysisBUT(cohort,Structure(), ...
    fMRIGraphAnalysis.NAME,'analysis 1', ...
    fMRIGraphAnalysis.CORR,fMRIGraphAnalysis.CORR_SPEARMAN, ...
    fMRIGraphAnalysis.NEG, fMRIGraphAnalysis.NEG_ZERO);

%% calculate 6 measures

m1 = gaBUT.calculate(Graph.DEGREE,1,0.80);
m2 = gaBUT.calculate(Graph.DEGREE,1,0.50);
m3 = gaBUT.calculate(Graph.DEGREEAV,1,0.75);
m4 = gaBUT.calculate(Graph.DEGREEAV,2,0.90);
m5 = gaBUT.calculate(Graph.TRIANGLES,2,0.10);
m6 = gaBUT.calculate(Graph.CPL,2,0.60);

%% create and add an empty measure

m7 = fMRIMeasureBUT();
gaBUT.add(m7)

%% existMeasure, getMeasures, getMeasure

[bool,i] = gaBUT.existMeasure(m4);
[ms,mi] = gaBUT.getMeasures(Graph.DEGREE,1);
[m,mi] = gaBUT.getMeasure(Graph.DEGREE,1,0.80);

%% calculate comparisons

c1 = gaBUT.compare(Graph.DEGREE,1,2,0.01,'M',50,'verbose',0);
c2 = gaBUT.compare(Graph.DEGREEAV,2,1,0.50,'verbose',0);
c3 = gaBUT.compare(Graph.DEGREEAV,2,1,0.80,'verbose',0);

%% getComparison, getComparisons

[c,ci] = gaBUT.getComparison(Graph.DEGREEAV,2,1,0.80);
[cs,ci] = gaBUT.getComparisons(Graph.DEGREEAV,2,1)

%% calculate random comparisons

n1 = gaBUT.randomcompare(Graph.DEGREE,1,0.01,'M',50,'verbose',0);
n2 = gaBUT.randomcompare(Graph.DEGREEAV,2,0.3,'verbose',0);
n3 = gaBUT.randomcompare(Graph.DEGREEAV,2,0.1,'verbose',0);

%% getRandomComparison, getRandomComparisons

[n,ni] = gaBUT.getRandomComparison(Graph.DEGREEAV,2,0.80);
[ns,ni] = gaBUT.getRandomComparisons(Graph.DEGREEAV,2)