const { app, BrowserWindow, shell } = require('electron');

const APP_URL = 'https://mori-apis-ai.vercel.app/';
const APP_ORIGIN = new URL(APP_URL).origin;

function createWindow() {
  const window = new BrowserWindow({
    width: 1180,
    height: 820,
    minWidth: 720,
    minHeight: 560,
    title: 'Mori',
    autoHideMenuBar: true,
    webPreferences: {
      contextIsolation: true,
      nodeIntegration: false,
      sandbox: true,
    },
  });

  window.webContents.setWindowOpenHandler(({ url }) => {
    void shell.openExternal(url);
    return { action: 'deny' };
  });

  window.webContents.on('will-navigate', (event, destination) => {
    try {
      if (new URL(destination).origin !== APP_ORIGIN) {
        event.preventDefault();
        void shell.openExternal(destination);
      }
    } catch {
      event.preventDefault();
    }
  });

  void window.loadURL(APP_URL);
}

app.whenReady().then(() => {
  app.setName('Mori');
  createWindow();
  app.on('activate', () => {
    if (BrowserWindow.getAllWindows().length === 0) createWindow();
  });
});

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') app.quit();
});
