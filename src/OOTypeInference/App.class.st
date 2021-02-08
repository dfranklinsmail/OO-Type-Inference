Class {
	#name : #App,
	#superclass : #Exp,
	#instVars : [
		'exp1',
		'exp2'
	],
	#category : #'OOTypeInference-Language'
}

{ #category : #'instance creation' }
App class >> exp: anExp1 exp: anExp2 [
	^ self new exp: anExp1 exp: anExp2
]

{ #category : #accessing }
App >> exp: anExp1 exp: anExp2 [
	exp1 := anExp1.
	exp2 := anExp2.

]

{ #category : #printing }
App >> printOn: aStream [
	exp1 printOn: aStream.
	aStream nextPut: $ .
	exp2 printOn: aStream.

]

{ #category : #printing }
App >> typeOf: env [
	"App (e1,e2) ->
           let ty_fun = typeof env e1 in
           let ty_arg = typeof env e2 in
           let ty_res = newvar () in
           unify ty_fun (TArrow (ty_arg,ty_res));
           ty_res"
| typFun typArg typRes |
typFun := exp1 typeOf: env.
typArg := exp2 typeOf: env.
typRes := self newvar.
typFun unify: (TArrow type: typArg arrow: typRes).
^typRes.


]
