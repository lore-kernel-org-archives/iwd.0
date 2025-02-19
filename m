Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3DF253F1C
	for <iwd@lists.linux.dev>; Wed, 19 Feb 2025 21:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739999286; cv=none; b=ruPqM+BIwFH9+BQTIEONSgZN9GqHaNZ++X7YxyNfke0LKm7aWa/9XLUjicqdiJBAJWUoXwmNJc9EH5uH8/N6lzeF+VpXCXSHNUzn7M5ptX8wTnh2B7lWUVDKriGHqEOdjOrVwI1pljYEym9MYsI9MsvuS1Mu4WfRKkpiozROgpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739999286; c=relaxed/simple;
	bh=XhrkuySuebRnEzkNFqM/yxiyXHW/6Kgu7Cce70a30Cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YjieyD0XCmVxVQiVY8lejVMUCPwys8cs8GgoduiVdkn/NjrzFVgnZlgw4F5RPSRMYmo8+83+AzXlilnstFukOvPHqEsgsyyxO/9VLyDHuXjG5hk804pWDl5iM5n8xpkfq6Sgw0xQnyYzn5EmW+Mn+UBdVg7O8JuDUwaxi7q+QcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xf6YIc66; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xf6YIc66"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso2603906d6.2
        for <iwd@lists.linux.dev>; Wed, 19 Feb 2025 13:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739999283; x=1740604083; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OSVg1nw23XkrJtGcKc7gxe1aigBbk/RHRYmWqiSLBmE=;
        b=Xf6YIc66XXq46E+YBIMIJUml47jDQRsRDNXUpTwYjQu0eQeQ40OkjBC0LsKImc1jeQ
         jtQzwVmobKD4gDshNlHKH3vz0Yk9n6r6+2QurI9O/VYoRKPwPYUF/N8UiI9tMIX03SEV
         YMBUR9fNp6DPvKuMMcGxu1sVI31/H90XlNEEsVYHGX1byuTPrRTSZVPIWWZlaL80+Ieg
         bxuvv4w5M2paQ8d3LJ7mlCGd5G5lO6wtvbGb8Zc57wMSwktxGK7h7H/Fbeqfvm+Btbqm
         b+JvBE5CJCQZLDDbKs3xrnO4KaIx10eKULyv0gJWFoVReh+ido5hLOofgsQ2tf+6qtc5
         gR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739999283; x=1740604083;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OSVg1nw23XkrJtGcKc7gxe1aigBbk/RHRYmWqiSLBmE=;
        b=ighNkHTpf02tSS5ogBVq/zHzw5MkOAnTvxIZjC/2W63sjHfJ8/a0/7vXzMuupgVSmH
         hbMSooyl6S5Hpk0ZpzlRHYiQ+XAYQSyBrtpr2tHPEO0k4Wd3ryh3mASNBPUyttALkm3f
         JBWSfHDw7RfSXqCWTZAB0gBVYBgV2xenuSzbb8ReHLFh66Nj1vpT+O3AFyHkrtDJXF6T
         5G1qGxeQmZFOnPqB8rMW0uG+MFqLNT3zI8oKGHoK4RTNzhyG+f65X6uGFqVe0UFsWwIZ
         vEXmJ2sppv++YvYEFoI6a5OaiJIlcaPWcI+Z7WhLM+3h109BflUhYEQ8RzUNse0dVVSO
         tJUg==
X-Gm-Message-State: AOJu0YwFE9n3m0N0hHsohP4eZUEPfHsj5fEGazS0SBv9O8YrpRc70KoW
	jihLrESg9iUJ2mtKSY4u93TgHzQqIrOIHDmNZW9Xr7Xq/W8ygnhU3w/ZZA==
X-Gm-Gg: ASbGncvHXn/7WQlX73L0Y+bL5kk4hwUmjES9FsWTXgnVJ7penrbf8uHaU4zJuxIN1U/
	j4kf1EJUtLZLDEa6Nn5mcHMMGQPLqZpvAussP+ER7Ic2vA5KMrOxz/NGgoVsLN0+YMU7nr2EVvQ
	wc8kxiUq687grLjeo6PpPAODWL5G6d/23OAReRoAQh/sjPOVjsR1XUHaDyRbjvVuwX1uzEPk6ko
	7A8Byqv2UdlG6tHp/deXh6ZBi6j47jX5pIVNxMJVRdwA0ZkAn5Ko1KwjK98UEAi/0idCjCfRlVw
	HgUwSEOlyR6e5Hbdu7Y=
X-Google-Smtp-Source: AGHT+IEoxKhgQI3lHiIoKMNPZEUOpA6rGq/JhgEOQqhMH0YLcLgaTi/MAGF+kzKj9QNRdnjcE8zQ9A==
X-Received: by 2002:ad4:594d:0:b0:6d4:dae:6250 with SMTP id 6a1803df08f44-6e66cd0c85dmr321451406d6.34.1739999283399;
        Wed, 19 Feb 2025 13:08:03 -0800 (PST)
Received: from [10.100.121.195] ([152.193.78.90])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0b609b558sm136680685a.68.2025.02.19.13.08.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 13:08:03 -0800 (PST)
Message-ID: <8efeda12-ade2-4f90-b0bb-3aa7adb3bf14@gmail.com>
Date: Wed, 19 Feb 2025 13:08:01 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Exposing bssid information
To: James Hanley <jhanley@dgtlrift.com>
Cc: iwd@lists.linux.dev
References: <CAF++6AMG1Jj8cWS0rmSgLPZqCAgRU1o1wgrUaBsOvhGJvrtzYQ@mail.gmail.com>
 <97112988-3681-4192-abb2-9a9ee6d9552d@gmail.com>
 <CAF++6AMYxXJZg_im3z_4PDgUj0tr7t4Ag0KFetoTu-SKuYcYVQ@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAF++6AMYxXJZg_im3z_4PDgUj0tr7t4Ag0KFetoTu-SKuYcYVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

On 2/19/25 12:42 PM, James Hanley wrote:
> Thanks - this is really helpful for direction. I was going to
> initially brute force load all the attributes into a new interface,
> but it seems the preferred course from your suggestion is to gather
> the ESSID information and query each node individually for the BSSID
> information and populate that method with the associated details?

Properties, but yes. All the information you seek should already be 
within the scan_bss structure. So you'd really just need to add getters 
for each extra piece of info you want (RSSI, SNR, etc). The address is 
already there [1] so you should be able to add more getters following 
that as an example.

[1] 
https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/network.c#n2184


> One point that I'm stumbling on in testing the pristine codebase is
> accessing the ExtendedServiceSet property:
> test-wifi/test# dbus-send --system --type=method_call --print-reply
> --dest=net.connman.iwd /net/connman/iwd/0/2/53-elided-53_psk
> net.connman.iwd.Network.ExtendedServiceSet
> Error org.freedesktop.DBus.Error.NotFound: No matching method found
>
> When I query for the available interfaces and methods, I am able to see:
> test-wifi/test# dbus-send --system --type=method_call --print-reply
> --dest=net.connman.iwd /net/connman/iwd/0/2/53-elided-53_psk
> org.freedesktop.DBus.Introspectable.Introspect
> method return time=1739996534.609643 sender=:1.1090 ->
> destination=:1.1474 serial=2631 reply_serial=2
>     string "<!DOCTYPE node PUBLIC "-//freedesktop//DTD D-BUS Object
> Introspection 1.0//EN"
> "http://www.freedesktop.org/standards/dbus/1.0/introspect.dtd">
> <node>
>          <interface name="org.freedesktop.DBus.Introspectable">
>                  <method name="Introspect">
>                          <arg name="xml" type="s" direction="out"/>
>                  </method>
>          </interface>
>          <interface name="net.connman.iwd.Network">
>                  <method name="Connect">
>                  </method>
>                  <property name="Name" type="s" access="read"/>
>                  <property name="Connected" type="b" access="read"/>
>                  <property name="Device" type="o" access="read"/>
>                  <property name="Type" type="s" access="read"/>
>                  <property name="KnownNetwork" type="o" access="read"/>
>                  <property name="ExtendedServiceSet" type="ao" access="read"/>
>          </interface>
>          <interface name="org.freedesktop.DBus.Properties">
>                  <method name="Get">
>                          <arg name="interface_name" type="s" direction="in"/>
>                          <arg name="property_name" type="s" direction="in"/>
>                          <arg name="value" type="v" direction="out"/>
>                  </method>
>                  <method name="Set">
>                          <arg name="interface_name" type="s" direction="in"/>
>                          <arg name="property_name" type="s" direction="in"/>
>                          <arg name="value" type="v" direction="in"/>
>                  </method>
>                  <method name="GetAll">
>                          <arg name="interface_name" type="s" direction="in"/>
>                          <arg name="props" type="a{sv}" direction="out"/>
>                  </method>
>                  <signal name="PropertiesChanged">
>                          <arg name="interface_name" type="s"/>
>                          <arg name="changed_properties" type="a{sv}"/>
>                          <arg name="invalidated_properties" type="as"/>
>                  </signal>
>          </interface>
>          <node name="d8-elided-95"/>
>          <node name="d8-elided-55"/>
>          <node name="d8-elided-15"/>
>          <node name="d8-elided-95"/>
>          <node name="d8-elided-55"/>
>          <node name="d8-elided-95"/>
> </node>
> "
>
> Is there something I'm missing in attempting to access this detail
> from dbus-send?  Ultimately this is only for testing, but I do plan on
> using the DBusConnection c-api and getting it right with dbus-send
> will help me in defining the code flow.
>
> -Jim
>
> On Sat, Feb 15, 2025 at 3:29 PM James Prestwood <prestwoj@gmail.com> wrote:
>> Hi Jim,
>>
>> On 2/15/25 12:10 PM, James Hanley wrote:
>>> Hi,
>>> I’m looking to access (and/or expose) via dbus scanned information on
>>> bssid. Specifically, information as follows:
>>>
>>> {
>>>     "wifiAccessPoints": [
>>>    {
>>>     "macAddress": "f0:d5:bf:fd:12:ae",
>>>     "signalStrength": -43,
>>>     "signalToNoiseRatio": 0,
>>>     "channel": 11,
>>>     "age": 0
>>> },
>>> {
>>>     "macAddress": "3c:37:86:5d:75:d4",
>>>     "signalStrength": -35,
>>>     "signalToNoiseRatio": 0
>>> },
>>> {
>>>     "macAddress": "30:86:2d:c4:29:d0",
>>>     "signalStrength": -35,
>>>     "signalToNoiseRatio": 0
>>> }
>>>    ]
>>> }
>>>
>>> This would be for geolocation services such as skyhook or google
>>> https://developers.google.com/maps/documentation/geolocation/requests-geolocation
>>> to allow a device to estimate its location. It seems that what is
>>> exposed is ESSID information with the strongest AP, or does is this
>>> information already exposed in iwd and which module/interface should
>>> be used? If not exposed, which model would be the most appropriate to
>>> add this to - scan, station, or another - and what interface for dbus
>>> should the method be exposed through?
>> Take a look at the ExtendedServiceSet property [1] on the network
>> objects. This contains a list of BasicServiceSet object [2] paths. At
>> the moment the BasicServiceSet objects only contain the BSSID as this
>> was all I really needed for the affinity functionality, but I'm not
>> opposed to additional info being added such as signal strength/channel
>> etc. If you need any pointers for this let me know, but it should be
>> relatively straight forward to add extra properties in the interface
>> setup [3].
>>
>> iwctl also supports showing the BSS object paths/properties via:
>>
>> "station wlan0 get-bsses"
>>
>> [1]
>> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/network-api.txt#n54
>> [2]
>> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/basic-service-set.txt
>> [3]
>> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/network.c#n2196
>>> -Jim
>>>
