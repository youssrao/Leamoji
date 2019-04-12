# Neural networks notes

In each hemisphere of our brain, humans have a primary visual cortex containing 140 million neurons with tens of billions of connections between them. Human vision involves an entire series of visual cortices doing progressively more complex image processing. 

Neural networks take a large number of handwritten digits, known as training examples, and then develop a system which can learn from those training examples.

Neural networks use examples to automatically infer rules for recognizing handwritten digits, by increasing the number of training examples, the network can learn more to improve its accuracy. 


## Perceptrons
A type of artificial neuron is called a *perceptron*. 
The main neuron model used is one called the *sigmoid neuron*.


A perceptron takes several binary inputs and produces a single binary output. 
![alt text] (http://neuralnetworksanddeeplearning.com/images/tikz0.png)

A simple rule to compute the output: *weights* (w1, w2…), real numbers expressing the importance of the respective inputs to the output. 
The neuron’s output, 0 or 1, is determined by whether the weighted sum (∑jwjxj) is less than or greater than some *threshold value*. Just like the weights, the threshold is a real number which is a parameter of the neuron. 

The perceptron is a device that makes decisions by weighing up evidence. 

A simpler way to write the rule to compute the output is: *w* and *x* are vectors whose components are the weights and inputs, respectively. The *b* stands for bias. A perceptron’s bias is a measure of how easy it is to get the perceptron to output a 1. For a perceptron with a really big bias, it’s extremely easy for the perceptron to output a 1. But if the bias is very negative, then it’s difficult for the perceptron to output a 1. The bias leads to further notational simplifications. 

The first column of perceptrons – the first layer – is making three very simple decisions, by weighing the input evidence. The second layer of perceptrons is making a decision by weighing up the result from the first layer of decision-making. In this way, a many layer network of perceptrons can engage in sophisticated decision making. 
![alt text] (http://neuralnetworksanddeeplearning.com/images/tikz1.png)

We can use perceptrons to compute simple logical functions. We can use networks of perceptrons to compute any logical function at all. The computational universality of perceptrons is simultaneously reassuring and disappointing. It’s reassuring because it tells us that networks of perceptrons can be as powerful as any other computing device. But it’s also disappointing, because it makes it seem as though perceptrons are merely a new type of NAND gate. 

We can devise learning algorithms which can automatically tune the weights and biases of a network of artificial neurons. This tuning happens in response to external stimuli, without direct intervention by a programmer. These learning algorithms enable us to use artificial neurons in a way which is radically different to conventional logic gates. 

Neural networks can simply learn to solve problems, sometimes problems where it would be extremely difficult to directly design a conventional circuit.



## Sigmoid neurons
Sigmoid neurons are similar to perceptrons, but modified so that small changes in their weights and bias cause only a small change in their output. That’s the crucial fact which will allow a network of sigmoid neurons to learn.

∆output is a linear function of the changes ∆wj and ∆b in the weights and bias. This linearity makes it easy to choose small changes in the weights and biases to achieve any desired small change in the output. So, while sigmoid neurons have much of the same qualitative behavior as perceptrons, they make is much easier to figure out how changing the weights and biases will change the output. 

One big difference between perceptrons and sigmoid neurons is that sigmoid neurons don’t just output 0 or 1. They can have as output any real number between 0 and 1. 


## The architecture of neural networks
The leftmost layer in this network is called the input layer, and the neurons within the layer are called input neurons. The rightmost or output layer contains the output neurons, or, as in this case, a single output neuron. The middle layer is called a hidden layer, since the neurons in this layer are neither inputs nor outputs. (hidden means not an input or an output). 
![alt text] (http://neuralnetworksanddeeplearning.com/images/tikz10.png)

Some networks have multiple hidden layers. For example, the following four-layer network has two hidden layers: 
![alt text] (http://neuralnetworksanddeeplearning.com/images/tikz11.png)

While the design of the input and output layers of a neural network is often straightforward, there can be quite an art to the design of the hidden layers. In particular, it's not possible to sum up the design process for the hidden layers with a few simple rules of thumb. Instead, neural networks researchers have developed many design heuristics for the hidden layers, which help people get the behavior they want out of their nets. For example, such heuristics can be used to help determine how to trade off the number of hidden layers against the time required to train the network. 

Neural networks where the output from one layer is used as input to the next layer are called *feedforward neural networks*. This means there are no loops in the network – information is always fed forward, never fed back. 

There are other models of artificial neural networks in which feedback loops are possible. These models are called *recurrent neural networks*. The idea in these models is to have neurons which fire for some limited duration of time, before becoming quiescent. That firing can stimulate other neurons, which may fire a little while later, also for a limited duration. And so over time we get a cascade of neurons firing. 

Recurrent neural nets have been less influential than feedforward networks, in part because the learning algorithms for recurrent nets are less powerful. Recurrent networks are much closer in spirit to how our brains work than feedforward networks. And it’s possible that recurrent networks can solve important problems which can only be solved with great difficulty by feedforward networks.


## A simple network to classify handwritten digits
We can split the problem of recognizing handwritten digits into two sub-problems. First, we’d like a way of breaking an image containing many digits into a sequence of separate images, each containing a single digit.

Humans solve this *segmentation problem* with ease, but it’s challenging for a computer program to correctly break up the image.  Once the image has been segmented, the program then needs to classify each individual digit. 

There are many approaches to solving the segmentation problem. One approach is to trial many different ways of segmenting the image, using the individual digit classifier to score each trail segmentation. A trial segmentation gets a high sore if the individual digit classifier is confident of its classification in all segments, and a low score if the classifier is having a lot of trouble on one or more segments. The idea is that if the classifier is having trouble somewhere, then it’s probably having trouble because the segmentation has been chosen incorrectly. 

So, instead of worrying about segmentation we’ll concentrate on developing a neural network which can solve the more interesting and difficult problem, namely, recognizing individual handwritten digits. 
![alt text] (http://neuralnetworksanddeeplearning.com/images/tikz12.png)

The input layer of the network contains neurons encoding the values of the input pixels. The training data consists of many 28 by 28-pixel image of scanned handwritten digits. The second layer of the network is a hidden layer. The output layer of the network contains 10 neurons. 

## Learning with gradient descent
The first thing we’ll need is a data set to learn from – a so-called training data set. We use test data to evaluate how well our neural network has learned to recognize digits. Optimization is a big part of machine learning. Gradient descent is a simple optimization procedure that you can use with many machine learning algorithms. Gradient descent is a first-order iterative optimization algorithm for finding the minimum of a function.  














