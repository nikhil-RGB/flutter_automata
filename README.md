# flutter_automata


<div align="center">

<img width="230" alt="splash" align="left" src="https://user-images.githubusercontent.com/68727041/226305430-a6af27e0-3d39-4b97-8e48-6dae3f7a304b.png">

<img width="230" alt="system" align="center" src="https://user-images.githubusercontent.com/68727041/226305593-04e3c134-2a3d-4d1c-b8b2-35f4a6a5ddaf.png">

<img width="230" alt="automate" align="right" src="https://user-images.githubusercontent.com/68727041/226305613-6435aa49-ff2c-40e0-af76-a35c2618c367.png">
</div>

  <br><br>
  
<div align="center">
<img width="230" alt="initss" align="left" src="https://user-images.githubusercontent.com/68727041/226305527-2456439c-8e26-4294-8fc3-8dc9e28114a5.png">
  
<img width="230" alt="time gap" align="center" src="https://user-images.githubusercontent.com/68727041/226311042-8569aa01-f461-4cda-9d41-6aba24609d98.png">

<img width="230" alt="dialog" align="right" src="https://user-images.githubusercontent.com/68727041/226307593-6f8de8a9-6c15-43b7-b674-a42dfda5f9f3.png">

</div>
A flutter app to emulate the growth and control of a cell grid based on the concept of "Connway's Game of Life" to demonstrate "Cellular automata".

# Project Purpose and Explanation

### Cellular automata:

Cellular automata (CA) is a mathematical model for simulating complex systems, typically represented as a grid of cells that can be in one of a finite number of states. The cells change state based on a set of rules that determine how their state is influenced by the state of surrounding cells. This creates patterns and structures that evolve over time, often giving rise to complex and seemingly intelligent behavior. CA is used in a variety of fields, including physics, biology, and computer science, to study phenomena ranging from pattern formation to self-organization and emergent behavior.

### Connway's Game of Life: 

Conway's Game of Life is a cellular automaton that was first proposed by mathematician John Horton Conway in 1970. It is a simulation of simple rules that can generate complex and interesting patterns.

The simulation takes place on a two-dimensional grid of cells, where each cell is either "alive" or "dead". At each step, the state of each cell is updated based on the state of its eight neighboring cells according to the following rules:

If a cell is alive and has two or three live neighbors, it remains alive.
If a cell is dead and has exactly three live neighbors, it comes to life.
In all other cases, a cell dies or remains dead.
These simple rules can generate patterns ranging from simple oscillators to complex shapes that evolve over time. The Game of Life is often used as an example of cellular automata and is widely studied by mathematicians, computer scientists, and other researchers interested in complex systems and emergent behavior.
Thus, for Connway's Game of Life, the state transition diagram would be as follows:
Ruleset-
- Adjacent live cells <2, Cell death```(a)```
- Adjacent live cells>3, Cell death```(b)```
- Exactly 3 cells live in adjacent cells, dead cell comes back to life```(c)```
```
Symbols={a,b,c} 
States={Alive, Dead}
Initial State=Alive
Accepted State(s)={Alive}
```

<br>

<img width="355" alt="Finite automaton diagram" src="https://github.com/nikhil-RGB/flutter_automata/assets/68727041/7b5b1676-5a10-4b51-9728-a5ad6e506e5e">

<br>
<br>


> **Note**
> ### This project is under intermittent development, and may have janky performance under certain conditions(generally very large grids >55 * 55). I will attempt to improve this performance in future releases.

### Experimental Feature- Symmetric Encryption Key/IV generation:

Given the nature of cellular automaton and the way it progresses through multiple finite states, it can be used for generating pseudorandom numbers/strings which may serve the purpose of secret encryption keys.
Symmetric key generation refers to the process of generating a secret key that can be used to encrypt and decrypt data in a secure way. 
In this approach, the CA is initialized with a random initial state, and then the rules are applied iteratively to generate a sequence of states. The sequence of states is then converted into a sequence of numbers that can be used as a secret key.
The advantage of using CA for symmetric key generation is that the resulting sequence of numbers is highly random and unpredictable, which makes it very difficult for an attacker to guess the key. Additionally, the CA can be easily configured to produce keys of different lengths, which makes it suitable for a wide range of cryptographic applications.

#### Specefics:

Here are the specefic implementation details for this experimental feature:

- These encryption keys are generated using the current state of the Cellular Automaton :
    - At the time of key generation, the current state/generation of the cellular automaton is converted into a binary string--> 1 for alive/0 for 
      dead.
    - This binary string is then divided into substrings of 12, and each substring is converted into it's decimal equivalent number.
    - These numbers are then each encoded into a character. A string of jargon characters is thus generated. This string is then split into two 
       halves which are used to generate the secret key, and initialization vector.
    - Each of these two halves then undergo UTF-8 encoding and SHA-256 hashing.
    - The first 16 bytes of the two halves are then converted into the key and IV respectively.
    
- The algorithm used to test the symmetric key so-generated is AES(Advanced Encryption Standard). I used the 
   [encrypter](https://pub.dev/packages/encrypt) package for implementing the AES algorithm, since my purpose was only to showcase **key 
   generation**, not re-implement any encryption algorithm itself.

<div align="center">

<img width="230" alt="screen1" align="left" src="https://user-images.githubusercontent.com/68727041/229349865-6a564e8d-8e42-430e-8cf3-105026161dbd.jpeg">

<img width="230" alt="screen2" align="center" src="https://user-images.githubusercontent.com/68727041/229349875-eb4eca1c-44a7-434c-98e2-d4226a2c1b65.jpeg">

<img width="230" alt="screen3" align="right" src="https://user-images.githubusercontent.com/68727041/229349879-c0cfc8ec-18fe-48ef-8b52-56e3cb5835c7.jpeg">
</div>

