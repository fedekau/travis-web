`import Ember from 'ember'`
`import format from 'travis/utils/status-image-formats'`

View = Ember.View.extend
  templateName: 'status_images'
  classNames: ['popup', 'status-images']
  classNameBindings: ['display']

  repoBinding:  'toolsView.repo'
  buildBinding: 'toolsView.build'
  jobBinding:   'toolsView.job'
  branchesBinding: 'repo.branches'

  formats: [
    'Image URL',
    'Markdown',
    'Textile',
    'Rdoc',
    'AsciiDoc',
    'RST',
    'Pod',
    'CCTray'
  ]

  didInsertElement: ->
    @_super.apply(this, arguments)

    @setStatusImageBranch()
    @setStatusImageFormat()
    @show()

  show: ->
    @set('display', true)

  actions:
    close: ->
      @destroy()

  setStatusImageFormat: (->
    @set('statusImageFormat', @formats[0])
  )

  setStatusImageBranch: (->
    if @get('repo.branches.isLoaded')
      @set('statusImageBranch', @get('repo.branches').findProperty('commit.branch', @get('build.commit.branch')))
    else
      @set('statusImageBranch', null)
  ).observes('repo.branches', 'repo.branches.isLoaded', 'build.commit.branch')

  statusString: (->
    format(@get('statusImageFormat'), @get('repo.slug'), @get('statusImageBranch.commit.branch'))
  ).property('statusImageFormat', 'repo.slug', 'statusImageBranch.commit.branch')

`export default View`
