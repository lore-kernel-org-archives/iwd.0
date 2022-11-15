Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045258AAD
	for <iwd@lists.linux.dev>; Tue, 15 Nov 2022 19:41:35 +0000 (UTC)
Received: by mail-oi1-f174.google.com with SMTP id n186so15977744oih.7
        for <iwd@lists.linux.dev>; Tue, 15 Nov 2022 11:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1KEWNiBcTFg548FLoA7xVqLKOzE1bjY0m2cxaugx9ys=;
        b=ZO1sVlfskZ90cO4bQzeJ+M0aT89uyzQKBh8eg+VBB4wv99Zut9zKK0DQCLoRr3sEhh
         5ppvjnBO5PRhssAaeV0qi+dcZYdQn0s6axrrbmJtgICQyu8L3sZZDv5W7Tiar/Eod8cY
         N00MTkkYMhsxYXgoDUnbx9KoUhvLNIDPgTq9Hb8XzA44IY1i34EfHdJ6YmesEX09CYna
         J04e18d3GPtQ0i51h+j9okEfIBKzWppShZ4CN0pFoxq82HHJsZmyT3oUS6G0oVFUYEvv
         SKSOatAoWonnaoRgxvJdHSzzhVfC2hhLT0KUdoDjsz7LN0ZasOMsMVQwQwOqoQRL7Kt+
         1KrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1KEWNiBcTFg548FLoA7xVqLKOzE1bjY0m2cxaugx9ys=;
        b=BCrrKKSenoN9CSjfIP9OZoQHzDLis8BcJEkZrqljrBpCtimyBmaFIOyOzPTRZNML9i
         8b0QqRayAGRQbFwwv96KYRKChrV8FvfMUti44Ydr10wjK/dlyVDO+xD/A4Lz2Sf6n2fZ
         1hnqRv7bu2+EnpD4TaZhupiMzc5tkDvWJnnFwgB/F26jbrTkqq+Hjzaml6hw3igRn60H
         mdqx6HKy2CPwxkM88O3zbh3RIGmz/ecaw/kb2LxENWzUzVXpfhxqgGqM/npzz9qo8F4Z
         xn5aKFn+CDtSQvXVuCfwQiUiKQVgKuN2upGFW2twttYToY9mSu5HxQZqRXvkzo3lIHup
         pBhg==
X-Gm-Message-State: ANoB5pkpAYFPeT51BPVtezWNWFctzlvck3MNTKwbAy2fOoSTjr2itjFd
	NMfF4dCMX+cRBJ+hMz0zoCgEjR7BZes=
X-Google-Smtp-Source: AA0mqf6C+lTdYkjgzMUvmV36Ev5CesGV58XmnhtGuXvhVuHu44PK9FFDYM6RXN2gwkJChBDcvfmL9g==
X-Received: by 2002:aca:ac0f:0:b0:354:91e8:6983 with SMTP id v15-20020acaac0f000000b0035491e86983mr1111726oie.144.1668541294938;
        Tue, 15 Nov 2022 11:41:34 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id u14-20020a4a85ce000000b0049f098f4fb4sm5142749ooh.24.2022.11.15.11.41.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 11:41:33 -0800 (PST)
Message-ID: <c6bea4a7-4f4f-38f1-82ca-8db7d36a13f3@gmail.com>
Date: Tue, 15 Nov 2022 13:41:32 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/3] storage: Maintain the tls session cache object
Content-Language: en-US
To: Andrew Zaborowski <andrew.zaborowski@intel.com>
Cc: iwd@lists.linux.dev
References: <20221112011929.785388-1-andrew.zaborowski@intel.com>
 <a9af6470-6363-5362-f81d-0d612ab851da@gmail.com>
 <CAOq732L4CaibiV=7rtWLEW0Wk9wGycLnwKB8=39TnmNwwby4KQ@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CAOq732L4CaibiV=7rtWLEW0Wk9wGycLnwKB8=39TnmNwwby4KQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 11/14/22 19:29, Andrew Zaborowski wrote:
> Hi Denis,
> 
> On Mon, 14 Nov 2022 at 21:03, Denis Kenzior <denkenz@gmail.com> wrote:
>> On 11/11/22 19:19, Andrew Zaborowski wrote:
>>> Any
>>> sessions saved in relation to a specific network (ESS) should use group
>>> names ending in the storage_get_network_file_path encoding of the
>>> network's SSID+security type, so that storage.c can automatically drop
>>> these cache entries if the network is being forgotten.
>>
>> It seems overkill to encode the full path into the group name.  Perhaps a
>> hex-encoded SSID is enough?
> 
> It would be nice to include the security type, how about using the
> file name without the rest of the path?
> 

OK, but I'm still failing to understand why?  TLS will only be ever relevant to 
8021x.  You even hardcode 8021x security type in the EAP changes in patch 3 :)

The file isn't really user visible either.  No normal user would be opening 
it...  In my opinion just basing things on the SSID would be enough.

However, now that I think about this approach some more, I think it will fail 
for Hotspot networks.  Since removal of these won't be detected properly. 
Actually, any removal triggered by the user won't work either since this path 
doesn't use storage_network_remove().

I think you need to hook into known_networks_remove() instead.

>>> +     for (group = groups; *group; group++)
>>> +             if ((group_len = strlen(*group)) > path_len &&
>>
>> Hmm, >= path_len?
> 
> Ok, but using just the network's id as the group name wouldn't be a good idea.
> 

Why not?  What is the additional "EAP-" prefix buying you:

+	cache_group_name = l_strdup_printf("EAP-%s", eap_get_peer_id(eap));

Which seems to translate to "EAP-/var/lib/iwd/foo.8021x"?  Is 
"/var/lib/iwd/foo.8021x" really any 'worse'?  Or just "foo"? :)

Regards,
-Denis
