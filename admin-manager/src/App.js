// src/App.js
import React from 'react';
import { ThemeProvider, CssBaseline, Container, Box } from '@mui/material';
import theme from './styles/theme';
import Header from './components/Header.js';
import Sidebar from './components/Sidebar.js';
import AppRouter from './Router.js';
import './styles/App.css';

const App = () => {
  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <Box display="flex" sx={{ backgroundColor: '#f0f0f0' }}>
        <Box >
          <Sidebar />
        </Box>
        <Box width="100%" display="flex" flexDirection="column">
          <Header />
          <Container sx={{ backgroundColor: '#f0f0f0', minHeight: '100vh', paddingTop: '20px' }} >
            <AppRouter />
          </Container>
        </Box>
      </Box>
    </ThemeProvider>
  );
};

export default App;
