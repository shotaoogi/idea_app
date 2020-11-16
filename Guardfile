# frozen_string_literal: true

guard :rubocop, all_on_start: false, cli: ['-a'] do
  watch(/.+\.rb$/)
  watch(%r{(?:.+/)?\.rubocop(?:_todo)?\.yml$}) { |m| File.dirname(m[0]) }
end
