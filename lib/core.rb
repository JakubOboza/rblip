#!/usr/bin/env ruby

require 'net/http'
require 'uri'
require 'rubygems'
require 'json'
require 'CGI'

# Plz dont be mad ;)
class Hash
  def to_url_params
    "?" + URI.escape(self.collect{|k,v| "#{k}=#{v}"}.join('&'))
  end
end

module RBlipInfo
  VERSION = "0.0.1"
  API_VERSION = 0.02
  URL = "http://api.blip.pl"
  USER_AGENT = "rblip - Blip.pl api library for ruby version #{VERSION}"
end

class RBlipError < Exception
end

class RBlip
  include RBlipInfo
  URL_UPDATES = "http://api.blip.pl/updates"
  URL_DIRECTED = URL + "/directed_messages"
  URL_TAGS = URL + "/tags"
  URL_DASHBOARD = URL + "/dashboard"
  
  @@url_updates = URI.parse(RBlip::URL_UPDATES)
  @@url = URI.parse(RBlip::URL)
  
  @login = ""
  @password = ""
  
  def initialize(opts = {})
    @login = opts[:login]
    @password = opts[:password]
  end
  
  def set_status(status)
    url_updates = @@url_updates
    req = Net::HTTP::Post.new(RBlip::URL_UPDATES)
    req.basic_auth(@login,@password)
    req.set_form_data({'body'=> status }, ';')
    res = Net::HTTP.new(url_updates.host, url_updates.port).start {|http| http.request(RBlip.add_api_fields(req)) }
    JSON.parse(res.body)
  end
  
  
  def get_latest_global
    url = @@url
    req = Net::HTTP::Get.new(URL)
    req.basic_auth(@login,@password)
    res = RBlip.perform_request(url.host, url.port, req )
    JSON.parse(res.body)
  end
  
  def get_latest(opts = {})
    url = URI.parse(URL_UPDATES + "/updates" + opts.to_url_params)
    req = Net::HTTP::Get.new(URL_UPDATES)
    req.basic_auth(@login,@password)
    res = RBlip.perform_request(url.host, url.port, req)
    JSON.parse(res.body)
  end
  
  def get_directed_msgs(opts = {})
    url = URI.parse(URL_DIRECTED + "/all" + opts.to_url_params)
    req = Net::HTTP::Get.new(URL_DIRECTED)
    req.basic_auth(@login,@password)
    res = RBlip.perform_request(url.host, url.port, req)
    JSON.parse(res.body)
  end
  
  def get_tag_msgs(tag, opts = {})
    ustr = URL_TAGS + "/#{tag}"
    url = URI.parse(ustr + opts.to_url_params)
    req = Net::HTTP::Get.new(ustr)
    req.basic_auth(@login,@password)
    res = RBlip.perform_request(url.host, url.port, req)
    JSON.parse(res.body)
  end
  
  def dashboard(opts = {})
    url = URI.parse(URL_DASHBOARD + opts.to_url_params)
    req = Net::HTTP::Get.new(URL_DASHBOARD)
    req.basic_auth(@login,@password)
    res = RBlip.perform_request(url.host, url.port, req)
    JSON.parse(res.body)
  end
  
  protected
  
  def self.add_api_fields(req)
    req.add_field('User-Agent', USER_AGENT)
    req.add_field('X-blip-api', API_VERSION)
    req.add_field('Accept', 'application/json')
    req.add_field('Pragma', 'no-cache')
    req
  end
  
  def self.perform_request(host, port, req)
    Net::HTTP.new(host, port).start do |http|
      http.request(RBlip.add_api_fields(req))
    end
  end
    
end

