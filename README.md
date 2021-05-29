# ClassificationOfHeartDisease

This project was done as part of the final graduate thesis in the bachelor studies of the faculty.

Within this paper, data preprocessing in R was performed and the distribution of attributes within the data set was processed and presented. The implementation of the classification algorithm was done using neural networks and logistic regression and the results of these two methods were compared and presented.

Based on the given data on 250 patients, with certain characteristics or conditions (input variables), which of the remaining patients (47) will have or will not have certain coronary (ischemic) heart disease will be predicted. Namely, the machine, based on data on patients who have or do not have ischemic heart disease, learns how to predict the existence of ischemic heart disease in completely new or unknown patients based on their data.

The data set used for training and testing was taken from a publicly available database (http://archive.ics.uci.edu/ml) containing information on 303 patients, and the condition of each patient was defined with 14 parameters.

There are 13 input variables in this system
1) Age of the patient
2) Patient gender (1 = male; 0 = female)
3) Chest pain (four variables: 1- typical angina, 2 - atypical angina, 3 - nonanginal pain, 4: asymptomatic)
4) Pressure (blood pressure at rest)
5) Cholesterol (blood cholesterol level in mg / dl)
6) Sugar (blood sugar level higher than 120 mg / dl; 1 = yes; 0 = no)
7) ECG (values: 0 - normal; 1 - has ST-T abnormality; 2 - most likely left ventricular hypertrophy)
8) Maximum heart rate
9) Presence of angina (1 - yes; 0 - no)
10) Cardiac response to activity
11) A tilt of the top of the heart (1 - upsloping; 2 - flat; 3 - downsloping)
12) Blood vessels (0 to 3)
13) Thallium (3 - normal; 6 - fixed defect; 7 - reversible defect)

The predicted attribute has a value of 0 which represents = <50% narrowing of blood vessels, and a value of 1 => 50% narrowing of blood vessels, based on which patients are classified into healthy - 0 and sick (presence of ischemic heart disease) - 1. Therefore, there are two categories, healthy-class 0 and sick-class 1.

To implement the classification algorithm using neural networks in MATLAB, a neural network with two hidden layers was used. The number of input attributes is 13, and the number of outputs is 2: 0-healthy, 1-sick. The number of data set instances is 297, 250 were used for network training, and 47 for testing.
To implement the neural network cost function for two layers, the nnCostFunction function was used, which needs to be minimized. Feed-Forward Propagation neural network with and without regularization was applied. Network training was done through 300 iterations. The sigmoid function was used as the activation function.

As a result of applying these two methods (neural networks and logistic regression) for a given set of data on heart disease, an accuracy of 93.6% was obtained when using neural networks and an accuracy of 86.5% when applying logistic regression.
