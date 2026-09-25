# frozen_string_literal: true

name 'homebrew'

default_source :supermarket

run_list 'test::default'

cookbook 'homebrew', path: '.'
cookbook 'test', path: './test/cookbooks/test'
