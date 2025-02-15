Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED2513DDAE
	for <iwd@lists.linux.dev>; Sat, 15 Feb 2025 20:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739651391; cv=none; b=qt+sz2Pa9x38KWOprYN9mSshp+E/xOkd+SUA8JXI1LjOh2MsjbZ+kwbJKNJXsHl8gWveh2QOVcs3BO5I0WcNNFEGH1u5VN9vwsT5fqBzmfQ+Sz8UIGK2E6+0xtkIchguISjQOZ/TjClrqVcWwYQL+/Dh5uEWrhYcfpm58DkHsUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739651391; c=relaxed/simple;
	bh=qIy/8UDaTx7O2xFYn5H+j/m2pWUu0Bq+SKIKKciSYus=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ns4P8FalQlmBZD+Em+ZklWRYcdHUxpmYDVNZZ5y5TuSzVTuyLUSFJS1QaHV0aVPI42JcwvFmwOQ5avofDurYFdzjNmzpIyV8n8fZgHhbxof0xKp0pV/jZHQ7LeVhaj/qd0fjYTCtAPvyKXAnD8lPaZuoLcmtv2K7bSQRxoAtFU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwXojrn1; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwXojrn1"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-220d398bea9so44511735ad.3
        for <iwd@lists.linux.dev>; Sat, 15 Feb 2025 12:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739651389; x=1740256189; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qJp2+02gcqe3rIZ7mu1Z9CggZBdBBLmzkh3U0RQzQ6c=;
        b=KwXojrn1Gh/DLZ8bApjSH/cmu/apZSEjt8d9MZtl0Sd8MCQbBiqCsqy5nTyZ8CruOi
         /3so6qGLiNkmjGjA25r3CHodOU8X7M6ANbKbdbiXh2+YeYsUzqKO1f8Ofq6CzUAFAg9w
         jCSx9403onywK8CLoN0l/m+zKGjXuK4m/BqezkxeOXpkEZGJu3CeVgFfXALDs3HCdIgF
         JQCH0qx+/QSg6MhG4Osnmk48+BjSD4i6CpEyf2ppreu+8gsEPIaQ9kTTkBsoNempJ7jR
         9PZ3WuwpEpJWRa3Bvesqq0lu67C6S4l54VUC9g7jMqKL/OKvu/35oH30KBbjqYBc60F4
         /kag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739651389; x=1740256189;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qJp2+02gcqe3rIZ7mu1Z9CggZBdBBLmzkh3U0RQzQ6c=;
        b=CFy4ro+WUNgEJSeEf3zL9g+yJaf7NhP7hqunStdoliixgERj7EtqJZNuy1j0nJWRqQ
         ZC2d5w9TvR1HDSFfjxID91OI59/6X03nqvbOm4vK0mOVGibLSTDGiNgiW7ac8+4NXh3l
         rzgG8vBDxB7P4l57xZNGHox+AMZJwqxtuJTEmyXN8F961zZRIgYfvkBoOAgOkcRJ4kAh
         4W+igbB3u2kAe7B+krVtA/SbXPoU7D0XaYAxe2rwgPZqF22Pv+qUz8ax2/pnLFhGWHzB
         xFam1p1vUFGCDS4b9WiG/VQwBn5Q9CgTSt5BSbIyy2oaqSM7m/lvfxY945ThMWUjNfGl
         F6hg==
X-Forwarded-Encrypted: i=1; AJvYcCX4dZ8HdkoK02bj5KkToTJziuyNXypcFSr64ZvdIyVabi30C27Qj+I83yLCfMo0sRI8SnM=@lists.linux.dev
X-Gm-Message-State: AOJu0YxBe5cZBNGWWgKX2+eov3lo2j38aOiStagZPMomcquvTyYKRFVb
	SKBGonfs6TjTzhPNye/2hh+x873aE3mm8OV552uL5KWzjm3EsuS0sX+FKw==
X-Gm-Gg: ASbGncsDVJ2cLul1cz+Me2VIXZU4J3v9QcWahDr8dth+nIUUP9bpn+StPtHSIISBvXI
	yQXh8liAuHT1t2dcdoWUJIzwOtkeRc0ehhOg3MDbkqB8hO1Uq6jHv7knBNGat5dUd/3Ha0rdGEc
	Rv6wRg5VIac9ZZOfohJgxsVQGgZNnQnywe8RtWflvlR10Q8VnkhwwcWmd+egpSOayid+9yaiuM2
	nCLaNwYNwN4RpdhiptJS6wSsde0oiLUQO/4CV45vgKLQg1ArcOibca+aO3nOMYus5w5hHeQfn4L
	7voFA5Ue3lunxNOBxvmI0Q4VK50xVR0XSWNnVP/I8oU1o/tjbOkr/R/bztvv4VDkGXfz
X-Google-Smtp-Source: AGHT+IFNwptDYRYl6Ki9d5r/5X0HfcouP9IN0fIiWpczaj7fbSXvbEmG6czMVPEn9sn7MbZJ6BkkIQ==
X-Received: by 2002:a17:903:3d0c:b0:220:d5a4:3ac with SMTP id d9443c01a7336-221040d7a6fmr62584065ad.45.1739651388706;
        Sat, 15 Feb 2025 12:29:48 -0800 (PST)
Received: from [192.168.1.26] (h69-130-12-20.bendor.broadband.dynamic.tds.net. [69.130.12.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d545d046sm47752865ad.114.2025.02.15.12.29.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Feb 2025 12:29:48 -0800 (PST)
Message-ID: <97112988-3681-4192-abb2-9a9ee6d9552d@gmail.com>
Date: Sat, 15 Feb 2025 12:29:47 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Exposing bssid information
To: James Hanley <jhanley@dgtlrift.com>, iwd@lists.linux.dev
References: <CAF++6AMG1Jj8cWS0rmSgLPZqCAgRU1o1wgrUaBsOvhGJvrtzYQ@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CAF++6AMG1Jj8cWS0rmSgLPZqCAgRU1o1wgrUaBsOvhGJvrtzYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jim,

On 2/15/25 12:10 PM, James Hanley wrote:
> Hi,
> I’m looking to access (and/or expose) via dbus scanned information on
> bssid. Specifically, information as follows:
>
> {
>    "wifiAccessPoints": [
>   {
>    "macAddress": "f0:d5:bf:fd:12:ae",
>    "signalStrength": -43,
>    "signalToNoiseRatio": 0,
>    "channel": 11,
>    "age": 0
> },
> {
>    "macAddress": "3c:37:86:5d:75:d4",
>    "signalStrength": -35,
>    "signalToNoiseRatio": 0
> },
> {
>    "macAddress": "30:86:2d:c4:29:d0",
>    "signalStrength": -35,
>    "signalToNoiseRatio": 0
> }
>   ]
> }
>
> This would be for geolocation services such as skyhook or google
> https://developers.google.com/maps/documentation/geolocation/requests-geolocation
> to allow a device to estimate its location. It seems that what is
> exposed is ESSID information with the strongest AP, or does is this
> information already exposed in iwd and which module/interface should
> be used? If not exposed, which model would be the most appropriate to
> add this to - scan, station, or another - and what interface for dbus
> should the method be exposed through?

Take a look at the ExtendedServiceSet property [1] on the network 
objects. This contains a list of BasicServiceSet object [2] paths. At 
the moment the BasicServiceSet objects only contain the BSSID as this 
was all I really needed for the affinity functionality, but I'm not 
opposed to additional info being added such as signal strength/channel 
etc. If you need any pointers for this let me know, but it should be 
relatively straight forward to add extra properties in the interface 
setup [3].

iwctl also supports showing the BSS object paths/properties via:

"station wlan0 get-bsses"

[1] 
https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/network-api.txt#n54
[2] 
https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/doc/basic-service-set.txt
[3] 
https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/src/network.c#n2196
>
> -Jim
>
