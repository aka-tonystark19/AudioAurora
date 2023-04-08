import './App.css';
import { BrowserRouter, Route, Routes } from 'react-router-dom';
import Dashboard  from './components/Dashboard';
import LogIn from './components/Login';
import Register from './components/Register';

function App() {

  // The Main Front End App;
  return (
    <div className='App'>
      <h1 className="text-center">Audio Aurorra</h1>
      <div className="App-content">
      <BrowserRouter>
        <Routes>
          <Route path='/' element={<Dashboard/>} />
          <Route path='/login' element={<LogIn/>} />
          <Route path='/register' element={<Register/>} />
        </Routes>
        {/* Add the login page to the route */}

      </BrowserRouter>
      </div>
    </div>
    
  );
}

export default App;