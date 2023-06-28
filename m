Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11EC28F2
	for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 14:54:28 +0000 (UTC)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-565a8d9d832so441219eaf.1
        for <iwd@lists.linux.dev>; Wed, 28 Jun 2023 07:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687964067; x=1690556067;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fs/ANQREV16BJT6OL+N6HjDCGG0j+2LyokbBlFMUbac=;
        b=swMs7kopFozXnN1XWb4TV5FtcS0P/mfoShJ1y5q/lVvzQA2+AKuJv5CdR7M4aMxhZQ
         d9eCVkK/kaCtY/SlSUQ/7+k/nWlIN+PTtK43ABm19s5y6qy9rtkPYiQyLfaCho1kxgPL
         bDNt04iScNmN4D8CtnXX0K1ugUfPhgUmBPsyLgEBWJLteb6rqvXVFf9NwLfJQeEdx+4u
         boSDgD0TB/s0xhUEeslHDXMB/YpSs0vGZY/ZE45RYgxVDYmzclGCFnC6K4wNVSgfrRhe
         NzD1ntUxpxzM6UjRfz9Drrf+f+9Zi5QQ/X3UZgKjKRKmw2zf7wrw6OnGjE7MN3xi6F8H
         5N/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687964067; x=1690556067;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fs/ANQREV16BJT6OL+N6HjDCGG0j+2LyokbBlFMUbac=;
        b=d5NA0wL80A/XUmUWXb87rrHQOQTOlGxu8a6EK9bpQfW3yA1xabvRdYK7/dXfNe/88t
         JD47nTcypyx6wk6QeyoqdGaaGcDhGRNgCrCzFJstFztW34GxZe+bvaJo6x/C2kCEIRik
         BzRCv0VX2/S4bJnezWh6k95tmN3to+VKKQBpbFrw4Puqy1Uu3JOquSMsEvwQcOa1qDlA
         f6DOybHhh3jlfSxvZSvS9yK9SyeQHQio/84gHS6exb4MUHd3a7TGGVGEDaeJeP8JxGwL
         oBxEKC2HtKjoa43IKZuSwaZC09xoTtT4gBSK93zGWIKxeJ7YSKWPN3vdhYoIjFsZP8Pt
         ApJQ==
X-Gm-Message-State: AC+VfDwy7sVux7g0LtPyDPyVpdJ6KMKXD7A4V0+T0zdhfTiHo9REYul+
	gTUOfosEx95I05Zbm8F1EX0=
X-Google-Smtp-Source: ACHHUZ5Garb2eqtjyKFB9qboxSbys5jCWQCww8H7qaReWhCx0O3DttjY6RQ/DUH/anKvKb/agHXUFg==
X-Received: by 2002:a4a:e601:0:b0:563:2489:dfe6 with SMTP id f1-20020a4ae601000000b005632489dfe6mr9740360oot.5.1687964067687;
        Wed, 28 Jun 2023 07:54:27 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id x9-20020a4ae789000000b00552502f3ae1sm4227231oov.39.2023.06.28.07.54.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 07:54:27 -0700 (PDT)
Message-ID: <9afac4da-a9d7-7855-9702-1b7500dafca1@gmail.com>
Date: Wed, 28 Jun 2023 09:54:25 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: iwd forgets network
Content-Language: en-US
To: Martin Petzold <martin.petzold@tavla.de>,
 James Prestwood <prestwoj@gmail.com>
Cc: James Tavares <jtavares@kvh.com>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <7794c62a-56d2-d34a-06e9-0b17edb235f7@tavla.de>
 <61D86659-745B-4228-AC0D-216E5CA292D2@kvh.com>
 <85b9e54c-dea7-672e-ecad-9382c8f6a7e7@tavla.de>
 <9d7f0362-67af-bbc4-2cc0-d4f8da123cd3@gmail.com>
 <e6f29266-7a7d-1fcf-2ce9-e96efe75a13d@tavla.de>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <e6f29266-7a7d-1fcf-2ce9-e96efe75a13d@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Martin,

> I have seen a more recent timestamp on the file. Also after reboot IWD seems to 
> set the timestamp. Can you confirm that IWD periodically sets the timestamp? 
> What is this for? How does it work? And can any write access (without user 
> command) be disabled?

iwd updates the profile's mtime using utimensat() any time a network is 
successfully connected to.  This directly maps to:
   string LastConnectedTime [readonly, optional]
on the KnownNetwork interface.

> 
> As there seems to be some sort of write access, IMHO there may be a bug which 
> causes the file to disappear. Maybe only with bind mounts, but also maybe not.
> 

Not due to the mtime I hope?  The worst case should be that we might fail to 
update it on a crash, but that's not something that really matters.

Regards,
-Denis
