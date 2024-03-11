Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A24A51C44
	for <iwd@lists.linux.dev>; Mon, 11 Mar 2024 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710181166; cv=none; b=FMnv+F4iQUqayksXhtB7AaQx+iaD0CmxJCb4VCotPeUlwBGYgQDD8tm27JahBdh7gyZCRCLyE4/fsFN4wyYYUvlb9NYwou5dgpZETko0CJdn7W0Sn+X3pVBt2m9MsRIIwsNiAbEshnj/vn6WDtQrSHu7M1I0ZPjy7VAYrCEeju4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710181166; c=relaxed/simple;
	bh=ZrVxUBPX51NJKpfkd+vltKZXGqq8wjBO+u+jqQgX9vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AUe7Fp7wrzDaLSXIhGd2Ss0poDvQ99FpiInbUSalkXMHVgenzs2D3/rh5kb4wO/kqey7fRfeOaHJG9Lu8A+JV4Dj5NRA5n8XZ1At8jS7HT11wEq6uxQYM67Fs2RovMebBT4/hi+c6qYd/OjVuAYEAPU/39lD0ygiJMZKipnDyoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=redpinelabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5682ecd1f81so4343917a12.0
        for <iwd@lists.linux.dev>; Mon, 11 Mar 2024 11:19:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710181162; x=1710785962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvKPMyPWfVAbkNTdl5NkjpaoaJLLrE1L7fn0OCyUBCQ=;
        b=u6s6TIjTCJkAeldhlVEDuCziLPTcTGjfR/LiRzylcYBZoweZErCD759vf+SBGdKm0p
         ARlf6jmam2HUfFiq5Tn9fuW/RL7+l7eG5lZhjbdi+YOOTuibL4W6q2AuUSihSyFWq4XO
         9/7abgZkPK3HzphGhN9cMedTAc2QiWhd2W3RtmjOWVjvQtkGY3L3+CRQyz2KfZOdU65t
         mBcjL83/iFz7PyDfrOrjoNFpD1rZ+au+unB1sQH+d9Ilm1DYjobcnqiwv3/2XuHm9VHn
         xoyxJoBG9tNkz4KJ4W4onpMWpYSsb+1TY70pZqeiFvULNgIy9UFJAj/6kuc1EHY0YwjJ
         /YQQ==
X-Gm-Message-State: AOJu0YzYK3i3V5ZARSB+y/srtfYnqxxWmuNBmwKlNsIA4QPsATEXnodz
	5rOQmZjTYO2LMrrlQzCkawidKyna0J6OdP9pZLZv8uwdVkbeaJvcdcF3Pe9j83g=
X-Google-Smtp-Source: AGHT+IE7HtvJtuHTpJ1MpHnMTrEeD9WYBJRw71mfN9nNNOWlAdEfW9HPJ7VK0RyOG8FeJ66rDly6OQ==
X-Received: by 2002:a50:f68e:0:b0:566:f733:45da with SMTP id d14-20020a50f68e000000b00566f73345damr5412952edn.22.1710181162255;
        Mon, 11 Mar 2024 11:19:22 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id h19-20020aa7c613000000b005673e29cc0fsm3112451edq.54.2024.03.11.11.19.22
        for <iwd@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 11:19:22 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a450bedffdfso614036266b.3
        for <iwd@lists.linux.dev>; Mon, 11 Mar 2024 11:19:22 -0700 (PDT)
X-Received: by 2002:a17:906:395b:b0:a45:182e:29ba with SMTP id
 g27-20020a170906395b00b00a45182e29bamr4354302eje.30.1710181161981; Mon, 11
 Mar 2024 11:19:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <07009e2a-3ad7-4a8c-bcbf-a665a19bd03f@tavla.de> <26f4ecf5-2f67-43f4-b197-9caea5ce9319@tavla.de>
In-Reply-To: <26f4ecf5-2f67-43f4-b197-9caea5ce9319@tavla.de>
From: Bryce Johnson <bryce@redpinelabs.com>
Date: Mon, 11 Mar 2024 12:19:10 -0600
X-Gmail-Original-Message-ID: <CADXxVSKSA66S+PJLrdZV5mvHn+dYjFJ7K8E=YMNfiUfTHv46+g@mail.gmail.com>
Message-ID: <CADXxVSKSA66S+PJLrdZV5mvHn+dYjFJ7K8E=YMNfiUfTHv46+g@mail.gmail.com>
Subject: Re: Using bind mount for /var/lib/iwd results in zero directory (and
 no links) and no connections stored
To: Martin Petzold <martin.petzold@tavla.de>
Cc: iwd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi Martin,

> Is there an iwctl command to drop / forget ALL existing connections?
>
> #####

I would be interested if there was a way to do it with iwctl, but I
have a python script I use to forget all wifi networks, Here is the
important part:

#!/usr/bin/python3

import dbus

bus = dbus.SystemBus()

try:
    # IWD forgot section: based on
https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/test/list-known-networks
    manager = dbus.Interface(bus.get_object('net.connman.iwd', '/'),
                            'org.freedesktop.DBus.ObjectManager')

    for path, interfaces in manager.GetManagedObjects().items():
        if 'net.connman.iwd.KnownNetwork' not in interfaces:
            continue

        network = interfaces['net.connman.iwd.KnownNetwork']

        obj = dbus.Interface(bus.get_object('net.connman.iwd', path),
                            'net.connman.iwd.KnownNetwork')
        obj.Forget()

        print("%s network forgotten in IWD" % network['Name'])


except:
    print("Skipping IWD forget network")
    pass
