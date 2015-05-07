# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#= require 'jquery'
#= require 'jquery_ujs'
#= require 'bootstrap-sprockets'
#= require 'handlebars'
#= require 'dataTables/jquery.dataTables'
#= require 'dataTables/bootstrap/3/jquery.dataTables.bootstrap'
#= require 'admin/tables'
#= require 'admin/forms'
#= require 'ckeditor/init'
#= require 'jquery.tagsinput'
#= require 'dropzone'

$ ->
  $(".tags").tagsInput
    width: '100%',
    defaultText: '',
    delimiter: [',']
