import sys  
reload(sys)  
sys.setdefaultencoding('utf8')
from collections import Counter
from nltk.stem import WordNetLemmatizer
wordnet_lemmatizer = WordNetLemmatizer()




from nltk.stem.lancaster import LancasterStemmer
lancaster_stemmer = LancasterStemmer()
#wordnet_lemmatizer.lemmatize()

def uni(arr):   # delete reduplicant in an arrary
	return list(set(arr))

def bigram(arr):
	t=arr+['_\$']
	h=['_\^']+arr
	return zip(h,t)


names=['neg','pos','neu']

train=[]
for i in names:
	with open('tk_'+i+'.txt','r') as handel:
		train.append(handel.readlines())

train=[[i.split('\t')[0] for i in train[0]],[j.split('\t')[0] for j in train[1]], [k.split('\t')[0] for k in train[2]]]

#remove duplicates
for i,j in  enumerate(train):
	k=uni(j)
	train[i]=k



print "get parameter\n"
###unigram###
import re

def bag_n(input):
	'''
	0 = non neg and non q
	1 = 	neg and non q
	2 = non neg and 	q 
	3 = 	neg and 	q
	'''
	def have_neg(g):
		out=0
		for i in g:
			target="(.+n't|not)"
			m=re.match(target,i)
	 		if m:
				out=1
	 	return out
	def is_q(g):
		out1=0
		out2=0
		for i in g:
			m=re.match(r'who|what|how|where|when|why|which|whom|whose',i,re.I)
			if m:
				out1=1
			m=re.match(r'\?',i)
			if m:
				out2=1
		return out1*out2
	return have_neg(input)*1+is_q(input)*2 


no_cl_train_bag=[[],[],[]]
no_cl_train_bag2=[[],[],[]]
train_bag=[[[],[],[]], [[],[],[]], [[],[],[]], [[],[],[]] ]
train_bag2=[[[],[],[]], [[],[],[]], [[],[],[]], [[],[],[]]]
train2=[[],[],[]]

for i,j in enumerate(train):
	index=0
	for k in j:
		print '{} out of {}\t part {} out of {} parts\n'.format(index,len(j),i,len(train))
		index=index+1
		#sen=k.lower()
		sen=k.split()
		sen=map(wordnet_lemmatizer.lemmatize,sen)  # i.e sen=[wordnet_lemmatizer.lemmatize(ii) for ii in sen]
		no_cl_train_bag[i]=no_cl_train_bag[i]+sen
		no_cl_train_bag2[i]=no_cl_train_bag2[i]+bigram(sen)
		bag_number=bag_n(sen) # 0 
		train_bag[bag_number][i]=train_bag[bag_number][i]+sen
		train_bag2[bag_number][i]=train_bag2[bag_number][i]+bigram(sen)
		train2[i].append(sen)

bag_c=[[], [], [], []]
bag2_c=[[], [], [], []]

for k,m in enumerate(train_bag):
	neg_c=Counter(m[0])
	pos_c=Counter(m[1])
	neu_c=Counter(m[2])
	all_c=neg_c+pos_c+neu_c
	for i in neg_c:
		neg_c[i]=neg_c[i]*1.0/all_c[i]
	for i in pos_c:
		pos_c[i]=pos_c[i]*1.0/all_c[i]
	for i in neu_c:
		neu_c[i]=neu_c[i]*1.0/all_c[i]
	bag_c[k].append(neg_c) 	#bag_c[n][0] = neg
	bag_c[k].append(pos_c)	#bag_c[n][1] = pos
	bag_c[k].append(neu_c)	#bag_c[n][2] = neu

for k,m in enumerate(train_bag2):
	neg_c=Counter(m[0])
	pos_c=Counter(m[1])
	neu_c=Counter(m[2])
	all_c=neg_c+pos_c+neu_c
	for i in neg_c:
		neg_c[i]=neg_c[i]*1.0/all_c[i]
	for i in pos_c:
		pos_c[i]=pos_c[i]*1.0/all_c[i]
	for i in neu_c:
		neu_c[i]=neu_c[i]*1.0/all_c[i]
	bag2_c[k].append(neg_c) 	#bag2_c[n][0] = neg
	bag2_c[k].append(pos_c)		#bag2_c[n][1] = pos
	bag2_c[k].append(neu_c)		#bag2_c[n][2] = neu


neg_c=Counter(no_cl_train_bag[0])
pos_c=Counter(no_cl_train_bag[1])
neu_c=Counter(no_cl_train_bag[2])
all_c=neg_c+pos_c+neu_c

for i in neg_c:
	neg_c[i]=neg_c[i]*1.0/all_c[i]

for i in pos_c:
	pos_c[i]=pos_c[i]*1.0/all_c[i]

for i in neu_c:
	neu_c[i]=neu_c[i]*1.0/all_c[i]


neg_c_bi=Counter(no_cl_train_bag2[0])
pos_c_bi=Counter(no_cl_train_bag2[1])
neu_c_bi=Counter(no_cl_train_bag2[2])
all_c_bi=neg_c_bi+pos_c_bi+neu_c_bi

for i in neg_c_bi:
	neg_c_bi[i]=neg_c_bi[i]*1.0/all_c_bi[i]

for i in pos_c_bi:
	pos_c_bi[i]=pos_c_bi[i]*1.0/all_c_bi[i]

for i in neu_c_bi:
		neu_c_bi[i]=neu_c_bi[i]*1.0/all_c_bi[i]



def sent_ana_bi_uni(input): #['w1 w2 ... ']
	sen=input.split()
	try:
		sen=map(wordnet_lemmatizer.lemmatize,sen)
	except:
		print sen
	#sen=sen[1:-1]
	#sen=merge(sen,"(.+n\'t|not)") # convert [ "not", 'happy', 'to']  to [ "nothappy", 'to' ]
	bi_k=bigram(sen)
	k=bag_n(sen)
	score=[0,0,0]  # score=[pos,neg,neu]
	for i in sen:
		score[0]=score[0]+bag_c[k][0][i]+neg_c[i]
		score[1]=score[1]+bag_c[k][1][i]+pos_c[i]
		score[2]=score[2]+bag_c[k][2][i]+neu_c[i]
	for g in bi_k:
		score[0]=score[0]+bag2_c[k][0][g]+neg_c_bi[i]
		score[1]=score[1]+bag2_c[k][1][g]+pos_c_bi[i]
		score[2]=score[2]+bag2_c[k][2][g]+neu_c_bi[i]
	for i,j in enumerate(score):
		score[i]=j*1.0/len(no_cl_train_bag[i]) #print score
	lable=['negative', 'positive', 'neutral']
	return lable[score.index(max(score))]


def sent_ana(input):
	sen=input.split()
	sen=[wordnet_lemmatizer.lemmatize(ii) for ii in sen]
	k=bag_n(sen)
	score=[0,0,0]  # score=[pos,neg,neu]
	for i in sen:
		score[0]=score[0]+bag_c[k][1][i]
		score[1]=score[1]+bag_c[k][0][i]
		score[2]=score[2]+bag_c[k][2][i]
	#print score
	score[0]=score[0]*1.0/len(train_bag[k][1])#*len(train[1]) #pos
	score[1]=score[1]*1.0/len(train_bag[k][0])#*len(train[0]) #neg
	score[2]=score[2]*1.0/len(train_bag[k][2])#*len(train[2])
	lable=['positive', 'negative', 'neutral']
	return lable[score.index(max(score))]

def main(out):
	print 'test.lable'+out
	with open('tk_test.txt','r') as test:
		with open('./result/test.lable'+out,'w') as lable:
			for j,i in enumerate(test):
				#print j
				out=sent_ana_bi_uni(i)
				lable.write('{}\n'.format(out))