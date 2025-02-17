return {
  'yetone/avante.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'stevearc/dressing.nvim',
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
  },
  build = 'make',
  opts = {
    provider = 'claude',
    claude = {
      endpoint = os.getenv 'AVANTE_ANTHROPIC_ENDPOINT' or 'https://api.anthropic.com',
      model = 'claude-3-5-sonnet-20240620',
      timeout = 30000,
      temperature = 0,
      max_tokens = 4096,
      api_key_name = "",
    },
    openai = {
      endpoint = os.getenv 'AVANTE_OPENAI_ENDPOINT' or 'https://api.openai.com/v1',
      model = 'gpt-4o',
      timeout = 30000,
      temperature = 0,
      max_tokens = 4096,
      api_key_name = "",
    },
  },
}
