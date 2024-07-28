// src/App.js
import React from 'react';
import { Container, Grid } from '@mui/material';
import Header from './components/Header.js';
import Sidebar from './components/Sidebar.js';
import AppRouter from './Router.js';
import './styles/App.css';

const App = () => {
  return (
    <div>
      <Header />
      <div className="main-container">
        <Grid container >
          <Grid item xs={2}>
            <Sidebar />
          </Grid>
          <Grid item xs={9}>
            <Container>
              <AppRouter />
            </Container>
          </Grid>
        </Grid>
      </div>
    </div>
  );
};

export default App;
