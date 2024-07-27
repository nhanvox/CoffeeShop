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
      <Container>
        <Grid container spacing={3}>
          <Grid item xs={3}>
            <Sidebar />
          </Grid>
          <Grid item xs={9}>
            <AppRouter />
          </Grid>
        </Grid>
      </Container>
    </div>
  );
};

export default App;
