import pandas as pd

#I cleaned the csv in Google Sheets by removing the NaNs in the numerical columns before
#importing it, I hope that's ok. I didn't see any specific instruction about cleaning
filepath = "SATscores_cleaned.csv"
df = pd.read_csv(filepath)

#1. Print the first 2 rows 
print(df.head(2))

#2. Print the first row 
print(df.head(1))

#3. Print rows 1019 
print(df.iloc[10:20])

#4. Print column names 
print(df.columns)

#5. Print the first 10 values of one column 
print(df["SCHOOL NAME"].head(10))

#6. Print the first 10 rows of three columns 
print(df[["DBN","SCHOOL NAME", "Num of SAT Test Takers"]].head(10))

#7.  Your three python statements (code) to answer the three questions below.
#Question 1 code
df['avgMathSAT'] = df['SAT Math Avg. Score'].astype(int)
print(df['avgMathSAT'].mean())

#Question 2 code 
df['numStudents'] = df['Num of SAT Test Takers'].astype(int)
filtered_df = df[(df['numStudents'] > 100) & (df['numStudents'] < 200)]
print(len(filtered_df))

#Question 3 code
df['avgReadingSAT'] = df['SAT Critical Reading Avg. Score'].astype(int)
if 'avgMathSAT'>"avgReadingSAT":
    print("The average Math score is higher.")
else:
    print("The average Critical Reading score is higher.")
