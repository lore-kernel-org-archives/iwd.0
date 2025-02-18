Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F0861FF2;
	Tue, 18 Feb 2025 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739885905; cv=none; b=bM6ASAKuvWO9j/5hvR+QPe6jovVj5rJ0aZgumUV0oqaNNJh/zxoCOOukarTCTNaxMikDrJPUkKL4qlVwWJB7VUTFw3E2Dm4e5LFBO3q9mqH8aTMzDlon6EvewCLwYyP8dbLxiTCwWcVWSj5qgOS5hSchVrEfIXs46zuRErcUoLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739885905; c=relaxed/simple;
	bh=2XKbEAgYnwWPhKmL/LkPAoXfN5b0mjdilOCCYBkmGzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Bow+oScDzEkvaPlqCtO1DG7Aic/OIJBm6i3J36D3bPc26NCunWZJfEAXl6K/MMqlkmUtm5cGEd0xE31s83i5dNLeljezOrp9yfAtZxr+dfDG8HzLZRJzABbdVLdqrNGhMiNR9J4P9TGyQ7G3F3imGLqOx3fEgX5MSEUVEvetByQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGxc/T5b; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGxc/T5b"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-220d132f16dso78723025ad.0;
        Tue, 18 Feb 2025 05:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739885903; x=1740490703; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=auTI5dXbycHff+E4W3Qu7UL/cwI8cRPKhbQmpXRdjxQ=;
        b=bGxc/T5b7AIKfEeODnB32mqOapt2OZmZNm0wo51TTfnKhAifuyq6iOrK3VbKpmn4RV
         ljZ/tdKjfgz1b4jNYd1xmXNZAuwM/FqVO+pJkSNMi9MzEYBmrQ33V3IPqETZ7Ekpwxwn
         87FI7d4iz+CLpb9dVWcZQ76BE5CFsRLvKRMRFEE4HhioN0pwLyU0QDEZCOiyOLcgxhGA
         dYWnaW2jqXg3Q+uQjQ4njYY8PkmIZNTPLzNiHrWtH5JIz+w/SGwlQFzTT8HFbGsgK64H
         SY7cIJjxxagsyItbpb2ovVPPBRoWMG/xhCgQsXZwpi/+UCg4Rhopx3RBjEhLD+PGB6i6
         bS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739885903; x=1740490703;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=auTI5dXbycHff+E4W3Qu7UL/cwI8cRPKhbQmpXRdjxQ=;
        b=bq3oPLHYta2DehsJm9OXFo39f6B+NJWSeDI3+UxqSLUkxySahjXd7N/bhtA8j3R3sj
         +Hg690WHxGqq+sGvfz1VcUeGInuJ5j5T94xIpjx+m/sHf+ZWrwqxdtZEy++NxGETd8+/
         6qqsZAHY3OGKPxqlKCFdjHsE6R977dGUEm4tYzR5G4/rWuOjJfacFf8nDvUVG0gYqr2k
         KXZgmMFN/yVyIyHWhcva/Z1oxR57vcx+uPyzRDLhaF8xXEc4mdWpmkox5rmtn1pksjnN
         D9HQlufpeF/6E74mZUR7SuBkRBkDyshOLywP+GpthaF3+nfg9qNS755zXlVj6AWtL1M8
         Mfug==
X-Forwarded-Encrypted: i=1; AJvYcCWPC3BL7znOCAOVBlLWLVJTi6bB4Xx1+yhyUlSpD+FYlyY8D10dmeJt6yRgcRbyYTIMaeeZLNWX@lists.linux.dev, AJvYcCXOn5LlqKEAlpy/Oir12zt99VKr73Hu2VtBPQpQYF9NSCIaCn18npOQsjezYxnXl3/FX7Qg@lists.linux.dev
X-Gm-Message-State: AOJu0Yze5AsMUFvWQZSMXYQ40Olxl3ULNgZPQEFO8fBWYc0M9AMJrEe6
	16Q1EbZYnhf0xG28frknS3ooeEt8LwnMvzoGkY4rp3qDTBYxqYdB
X-Gm-Gg: ASbGncvrnwa3TqMXj1GmdBdqL2oci8++5yL+DHCgWAGzRRhkwMiqhu81EAH/TEQJh0o
	xp3b96M8MfVeU6RNugppx4p3qtlgXK/w2lAq4u4n/W0MZBCeNqXbqiTKej8fF9Y1xXa8daegPhG
	hE6HnZ31UsPutE0CycGDhsqtTfv24QOi7Ia5yp7MMzqvZ+IgEbAjucJ+/ByMqVNhC2g23GMmhFR
	s6xOmkfVG/dcwo3WfbjuT88vwAqJ6ulhpLi3Ke738furpAkmFAdB1Wrki+OjugOVjcZJkZyxgXe
	hOm7xbT0mvCM84Xqttb1xEG2t4TOzrT7fl4oI+VdyqFdCrzf9cy/Hcue17uEHqghnTh1Aw==
X-Google-Smtp-Source: AGHT+IGGmEkeYZXD9vOqv4XZp/rT5zFCtsIvIIHItw+gtmhfozNXjAnTaxKvHSbg+a9lODg+MoL7sg==
X-Received: by 2002:a05:6a21:2d87:b0:1ee:73ee:bcf4 with SMTP id adf61e73a8af0-1ee8caac9e4mr24128384637.2.1739885903056;
        Tue, 18 Feb 2025 05:38:23 -0800 (PST)
Received: from [192.168.1.164] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73271a02648sm5232199b3a.107.2025.02.18.05.38.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 05:38:22 -0800 (PST)
Message-ID: <af619c24-18c2-488e-ba0d-69bb2d517ba7@gmail.com>
Date: Tue, 18 Feb 2025 05:38:22 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: How to elegantly engage/disengage AP mode
To: KeithG <ys3al35l@gmail.com>, iwd@lists.linux.dev, connman@lists.linux.dev
References: <CAG17S_Nkb6jH_aBfAzWiqVqY7PUZ5rQJsHo3WzvfPtBa0E57iA@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAG17S_Nkb6jH_aBfAzWiqVqY7PUZ5rQJsHo3WzvfPtBa0E57iA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Keith,

On 2/17/25 4:58 PM, KeithG wrote:
> Hi. I am soliciting ideas on how to elegantly engage/disengage AP mode
> when configuration is needed on a headless device.
>
> What we do now: We use connman as our connection manager with iwd
> handling wlan duties. At first boot our headless RPi based appliance
> checks to see if it has a valid ethernet address on either the wlan or
> the ethernet. If not, it creates an AP on a made up MAC address and
> launches (with either IWD or Hostapd) an AP to allow a connection to
> configure the internet. This works fine and we can use this to
> configure the RPi and when we select a valid SSID with connman and
> type in the password, it brings the AP down and connects to the SSID.
> All good.
>
> The problem: What happens if the SSID goes away either because we
> moved the Pi or the SSID goes away? What we would like is it to scan
> for a known SSID and reconnect if it finds one, (which it already
> does) and if ones does not appear, to restart AP mode so we can
> connect to it. If it finds an SSID while we are connecting, continue
> to set up, but if the SSID reappears and no-one has connected, to then
> shut down AP and re-connect to the SSID.
>
> Question: Are there any elegant ways of doing this? We currently use
> scripts and such to look at connmanctl and iwctl, but could start
> digging into dbus, to monitor what is going on if needed. We thought
> this may have been solved previously and wanted to ask here.
>
> Any ideas? This seems like something that would be useful for just
> about any headless internet connected device.

I'm not too sure there is anything more that IWD could really do to 
support this use case. At the moment I think your main limiting factor 
is trying to use command line utilities + scripts to create this 
application. These tools aren't API stable and never will be so your 
always going to have maintenance if something changes. DBus on the other 
hand is API stable and you can rely on the APIs to stay consistent 
between IWD releases.

Based on other smart devices I have used, this is what I would do:

  - Device starts up, check if there are any known network profiles.

     - If yes, let autoconnect do its thing. At this point your "done" 
already.

     - If no, start AP mode and wait for a connection/configuration.

- Have a "reset" button on the device and when pressed/held down erase 
the known network profile and reboot

Doing the above you don't have to handle any special logic of the 
configured AP disappearing. Once the profile is configured that is the 
network and the device should connect to it unless reset.

Thanks,

James

