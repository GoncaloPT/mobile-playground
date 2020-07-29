import React from 'react';
import Header from './components/header/header'
import Login from './components/login/login'
import './App.css';

function App() {
  return (
    <div className="App">
      <Header />
      <div className=" container">
        <Login/>
      </div>
    </div>
  );
}

export default App;
