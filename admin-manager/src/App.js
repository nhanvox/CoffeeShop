// src/App.js
import React from 'react';
import { Container, Box } from '@mui/material';
import Header from './components/Header.js';
import Sidebar from './components/Sidebar.js';
import AppRouter from './Router.js';
import './styles/App.css';

const App = () => {
  return (
    <Box display="flex">
      <Box width="20%">
        <Sidebar />
      </Box>
      <Box width="100%" display="flex" flexDirection="column">
        <Header />
        <Container>
          <AppRouter />
        </Container>
      </Box>
    </Box>
  );
};

export default App;
