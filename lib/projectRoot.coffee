# find the root for whatever project you're working in
{dirname, existsSync, join} = require 'path'

exports.projectRoot = root = (dirname(dir) for dir in require.main.paths when existsSync(dir))[0]
exports.domainRoot = join root, 'domain'
exports.buildRoot = join root, 'build'
