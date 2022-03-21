Class {
	#name : #PorTITest,
	#superclass : #TITest,
	#category : #'PorTypeInference-Tests'
}

{ #category : #tests }
PorTITest >> testAppendPoor [

| porList aPor solution answer |
porList := OrderedCollection new.

aPor := Por left: 'Tself' right: 'p3'.
porList add: aPor.
aPor := Por left: 'p3' right: 'p2'.
porList add: aPor.
aPor := Por left: 'Tr' right: 'p6'.
porList add: aPor.
aPor := Por left: 'p6' right: 'p5'.
porList add: aPor.
aPor := Por left: 'Tself' right: 'p11'.
porList add: aPor.
aPor := Por left: 'p11' right: 'p10'.
porList add: aPor.
aPor := Por left: 'p9' right: 'p8'.
porList add: aPor.
aPor := Por left: 'Tself' right: 'p17'.
porList add: aPor.
aPor := Por left: 'p17' right: 'p16'.
porList add: aPor.
aPor := Por left: 'p15' right: 'p14'.
porList add: aPor.
aPor := Por left: 'Tr' right: 'p19'.
porList add: aPor.
aPor := Por left: 'p19' right: 'p18'.
porList add: aPor.
aPor := Por left: 'p13' right: 'p12'.
porList add: aPor.
aPor := Por left: 'p4' right: 'p0'.
porList add: aPor.
aPor := Por left: 'p7' right: 'p0'.
porList add: aPor.

solution := Por solve: porList.

answer := OrderedCollection new.
aPor := Por left: 'Tself' right: 'list'.
answer add: aPor.
self assert: solution equals: answer.


]
