Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB442500B4
	for <iwd@lists.linux.dev>; Wed, 19 Feb 2025 20:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739998445; cv=none; b=eYWLLrNEPoradoSj5S8AqLS5kra4AuYxwp//Q5k5wLvgkyg19Om6tewKopZTyvR4GL0nqE/NXhYtgW9yj9NCMVg9EHuja/uCPTKaDFzPtMuCMRXW78L80cupaj44rIrkx/7NftBZUN4VsQZxi1bkx+NINbXDbsbUeQqxH1UgAwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739998445; c=relaxed/simple;
	bh=LL9KiAmUM9fO4xZ0uUm2w+Chf58vKKU132R+4qa+xMc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JZ2hkQblAsDSU9XS/yuU4Hm5dVrt3bSMasXcezMOdsC8PmcWWSoP+yPWhY3Mo1nwgT56B7fcu+h7qZT6Q0hQW08bNekYrCtjAGq6O66VA2NY5E30+6fjeLexjwkj2OLQCUXNtXHm11d+WPPFxIz+a3NVbDguSVawNUclZ4XZbPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K24wNIiz; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K24wNIiz"
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3f37207259bso73480b6e.1
        for <iwd@lists.linux.dev>; Wed, 19 Feb 2025 12:54:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739998443; x=1740603243; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Xw22nasBpPFx0fUCcNtGj/2f/eNq9PXdplVChdjlWk=;
        b=K24wNIizKU+8J5mH59a0ppTH0lZ6H/0lNvfj8ZPhymafN76Mhxh9dewbaCI0XAs3SI
         /x8D1J3LAxBwDfFOcDKtdnr77QMTCTq/pGIbblnzx0vYWsmvgZwrR3ZZ2vhTQ7t3zZD9
         P2Emj1PhXAxEV87ljBgY60eVre6NuLMYV2biKXlHgzCFHebJtzLUcEpgMfU4fIKD/bdM
         /3INY7PF2wBwFx/bnP8KLS8AePU1so/MLTbVyUHuiX+4n456a2oKmLBpvtnlO/+Gx1RW
         MuGG9rpM24nM2lrjIaZ20GaGcIOT002Vc+6KE+BKBxPOk/LvL3++EWk/y/rsD27r7jEQ
         DuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739998443; x=1740603243;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8Xw22nasBpPFx0fUCcNtGj/2f/eNq9PXdplVChdjlWk=;
        b=uJA1PbBY4MhctHb/Xc3G9v3nBF/ZskYtbHGzeBbygADN5IdbOXb49s2IqVd23To4e9
         F4suSr/kzeVQ/Dvkec5JKbxkEgwW+GDJ35QimBwr4/NzIo2Rx+EZeeT/LbQS3D1reSoD
         RT3fBOGrFqh96JA3oI9SWfb8NQ1nRinA0xmBZvOiY5CvAgImzihSUEHIE0m1oLfaDD17
         unc9lnUUmby5whgEF2hsrn3rzkIuv7YlDfcrfBJMiqYGkio2x3LYGbcCo7qepBmr6bqw
         3reWXaKSvtAwDGyO6uEAJlbWqcKWUZjqAbUtSU31T4e7rIQwg5G5DJoibAUCRkxAxLfz
         zqhA==
X-Gm-Message-State: AOJu0YwuZ7/RRQnlyUs25o+hIj+VLrd4MAvbH5YsyduntlxyhBJ2emwE
	JFGfes5KruRxCXbyn+2ICx/bFvgEeT3T5CsyRPmYiE5lv+o0zx8H
X-Gm-Gg: ASbGncvv4/E5viycFLADX96DC4ypaZ5LCRHdn6PtQ8p/I/2zlhPIydFwSxOkhIv89sE
	MUrkJE3biJetTLq6xuTGByozucinyXIT3CZAcRfzNp8ApbLSr6O09Y56iUlEHNkc/aXnRSHOQ8F
	xxbtdiNeislc1Fx3uLFcPymU8+J9iEV/9OJNgtg2Qof8Rh7MW4XyWMT8KbhXrcejvYGWPhtHYGE
	SHr/NPwjYnpW8zKk3YDet9tQqOr8coR7rRBnI1THhVW90MbYxpKeI5WLKfjPm6uUpOCMZOzk3OH
	KoO6YBdPtvxeabJpWe0mnDMcKToA9RxRys0y8g3KkeNDvxgJVcaFRAAe
X-Google-Smtp-Source: AGHT+IEzc3WnBoziBcXKVEkHR+YNXd7nDlzGj/7lkL9ZzPTrRShKHrRdu05U57OqBHdl9j6D2rl5mA==
X-Received: by 2002:a05:6808:1455:b0:3f4:1879:2ae0 with SMTP id 5614622812f47-3f418792d76mr1632922b6e.9.1739998442929;
        Wed, 19 Feb 2025 12:54:02 -0800 (PST)
Received: from [192.168.1.25] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 5614622812f47-3f3fe437a98sm1959223b6e.29.2025.02.19.12.54.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 12:54:02 -0800 (PST)
Message-ID: <d4ae8e61-96ab-41bd-8e24-daf9a316eae0@gmail.com>
Date: Wed, 19 Feb 2025 14:53:59 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Exposing bssid information
To: James Hanley <jhanley@dgtlrift.com>, James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev
References: <CAF++6AMG1Jj8cWS0rmSgLPZqCAgRU1o1wgrUaBsOvhGJvrtzYQ@mail.gmail.com>
 <97112988-3681-4192-abb2-9a9ee6d9552d@gmail.com>
 <CAF++6AMYxXJZg_im3z_4PDgUj0tr7t4Ag0KFetoTu-SKuYcYVQ@mail.gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAF++6AMYxXJZg_im3z_4PDgUj0tr7t4Ag0KFetoTu-SKuYcYVQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 2/19/25 2:42 PM, James Hanley wrote:
> Thanks - this is really helpful for direction. I was going to
> initially brute force load all the attributes into a new interface,
> but it seems the preferred course from your suggestion is to gather
> the ESSID information and query each node individually for the BSSID
> information and populate that method with the associated details?
> 
> One point that I'm stumbling on in testing the pristine codebase is
> accessing the ExtendedServiceSet property:
> test-wifi/test# dbus-send --system --type=method_call --print-reply
> --dest=net.connman.iwd /net/connman/iwd/0/2/53-elided-53_psk
> net.connman.iwd.Network.ExtendedServiceSet
> Error org.freedesktop.DBus.Error.NotFound: No matching method found
> 

You are trying to invoke a method.  ExtendedServiceSet is a property.

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

^^^

>          </interface>
>          <interface name="org.freedesktop.DBus.Properties">
>                  <method name="Get">
>                          <arg name="interface_name" type="s" direction="in"/>
>                          <arg name="property_name" type="s" direction="in"/>
>                          <arg name="value" type="v" direction="out"/>

Use this or the GetAll method to query properties.

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

Try qdbus-viewer or d-feet.  Nicer to use than dbus-send.

> 
> -Jim

Regards,
-Denis
