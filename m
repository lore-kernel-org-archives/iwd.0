Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1921717FE2
	for <iwd@lists.linux.dev>; Tue,  9 May 2023 15:11:26 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ab01bf474aso45638095ad.1
        for <iwd@lists.linux.dev>; Tue, 09 May 2023 08:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683645085; x=1686237085;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UOIznkc7QXHVitT914tZfG6DqE0z6lGujJo0Wi94f7k=;
        b=QxrZP5y3RKIgE8AOBj97hI+0CnA2wAfKQVklP8s4anXM5Wj/o0vZ2cG9QiTviLS9Ig
         XN6XKUDfRS14phRxPQypEXuKBZ8657wh5k14bptJ4WXfLQ0ps7r+VjhIm1HIzigAvpba
         +Z1VWWYuLyWHY6zjpaX3CeUuzKSb0AjJLfKEbcBye4VYsoaO4FFYsar06oMnbvAO0DQz
         Iv/9aIkC8u3PP4VY5C4p/NC6Y7ihBRlQKvdIFciQBTgvJ3s39+NRSIhVvRTPai6monun
         fewP57ZUjQRc/yFpco7u30W2dLIwwJsSZ9PgV1ykrD4YSvqMRFNA3jHv8d5qED0kSD+f
         cMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683645085; x=1686237085;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UOIznkc7QXHVitT914tZfG6DqE0z6lGujJo0Wi94f7k=;
        b=kDbkazRroTEYoNeIOmg3ziXlP5J8c9ojeReOWducPlTx9adI7SCgU2zuwVaYPlYewT
         UzFc7t5Wr7m2unv0WuE7OpIJWzSxM2TnIi55b7MEKge/NZsSYkMiypTStUk/QlToMt5S
         miRQp9GjEbVCYdJRzkqskmN0OFzA7+6OvJmP7D7DzQ7TxEE947zqWBL4Y10Q4QCPKBU8
         q0wrgGyQUPHwbYqxi3mq5q86vly6v/OXHkhWVOM6vC5RXn9R1MKQbls/20mvc5r7xHS8
         +z6fDAAixNDh47qdpOwjBAIdqnY3sZl92/92F5qkMiT5voqTfMETNI1dhJZGMatSarn7
         50fw==
X-Gm-Message-State: AC+VfDydTSoxE+hxV0EWxLUTX996rfz5c2qYIOD06ygFKTMBVHPdLv01
	o7ElJWY82WU/heQi2JBdJotKfDHA+klaNQ==
X-Google-Smtp-Source: ACHHUZ5bRZDyLfdOuW7CT6NGRLwjE5dI9tUKEElM6xFDJ6Wpa4+BJYYjjsNSaeYGlOkbtBuotuTRqg==
X-Received: by 2002:a17:902:d4ce:b0:1ac:8837:df8 with SMTP id o14-20020a170902d4ce00b001ac88370df8mr6538698plg.6.1683645085559;
        Tue, 09 May 2023 08:11:25 -0700 (PDT)
Received: from [192.168.254.76] ([50.39.172.77])
        by smtp.gmail.com with ESMTPSA id g14-20020a1709029f8e00b001ac6b926621sm58645plq.292.2023.05.09.08.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 May 2023 08:11:25 -0700 (PDT)
Message-ID: <66b05814-cb78-40c7-929b-0e2ffa2027a6@gmail.com>
Date: Tue, 9 May 2023 08:11:24 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: powersave support
Content-Language: en-US
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Mike Silva <mike.silva@mikesilva.com>, iwd@lists.linux.dev
References: <9EF567DC-15CC-40C0-9AF8-D69E27B81ACF@mikesilva.com>
 <f5ccf370-5197-c9a4-61b6-2a130c7242de@gmail.com>
 <4F32B57B-3517-46EA-97F6-2B5DC172B952@holtmann.org>
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <4F32B57B-3517-46EA-97F6-2B5DC172B952@holtmann.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Marcel/Mike,

On 5/9/23 7:55 AM, Marcel Holtmann wrote:
> Hi James,
> 
>>> Does IWD support disabling/enabling WiFi powersave/power management?
>>
>> No, currently it doesn't.
>>
>>> Perhaps, I’m failing in finding it in the documentation. It’s possible to do this as needed with ifconfig, iwconfig, or NetworkManager, or to permanently configure them to enable or disable it at boot..
>>> If IWD doesn’t support this, it would be nice enhancement if IWD could when managing the adapter/connection, as some drivers do a poor job of handling powersave being on.
>>
>> Yes, I've recently seen instances of drivers handling this poorly. Are you envisioning something like these other tools, where power save is just toggled on/off?
>>
>> I think this could be done, and actually we do this manually every boot using iwconfig in the software stack I work with. The tricky part is PS is done per-interface and IWD doesn't have any concept of per-interface configurations.
> 
> if anybody uses iwconfig, then the problem is already there. iwconfig
> is an WEXT tool and deprecated. The driver is broken.

It doesn't have much to do with the tool, its just an NL80211 API to 
toggle power save. But yes, the driver is broken if it can't handle this 
properly... but this is the world we live in.

The reason I'm interested though is because there is no nice way to 
disable power save "automatically" unless you use NetworkManager. Apart 
from hooking in a script to disable it with iw/iwconfig (which we 
currently do). An option in IWD would be convenient.

> 
>> Denis might have preferences on this? but my initial thoughts would be something like:
>>
>> [General.wlan0]
>> PowerSave={on,off}
> 
> You can't tie anything to interface names. Then can change and are
> basically random names. The most you can do is tie it to the phy
> and its mode of operation.

True, it would have to be per-phy. But this too has the same problem if 
its a hotplug device...

We do have this concept of driver_flags already, for interface removal, 
but I'm not sure if power save is something that EVERYONE will want to 
disable for a given driver. Maybe it works for some use cases but not 
others.

Thanks,
James

> 
> Regards
> 
> Marcel
> 
