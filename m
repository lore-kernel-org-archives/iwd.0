Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853388BE2
	for <iwd@lists.linux.dev>; Thu, 17 Nov 2022 17:00:35 +0000 (UTC)
Received: by mail-oi1-f170.google.com with SMTP id n205so2526672oib.1
        for <iwd@lists.linux.dev>; Thu, 17 Nov 2022 09:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VkU5wKJfxtzkDW8PCXdDkizcAP5aPgUOWORxsR5FWWE=;
        b=eD92L9YnEL1at94ePajWQkJA9hx3NYrxZArgU+AfxXHsVqDzOYE85Im7iZAy8y7gZh
         k/NtVZl3n8xO1KvSXEcbBBG+3ysFV35xTUx2ztMb3gAU92gzvMQtlJ5j0mOf9vHAtscs
         3TFpFBRE4xIKFQ3yQEcBanHpi9tcjY6qcY3W2bGbXfDGvoBrvvbPK4tdZWmB7Wx/2oGT
         dYmfk/Zph7dN91HjxZiyZz1FmiombHIbuBX27OrqkPsvqKFV84QJ2//B2BqyJdEEMnnh
         QKIaAqvoazxF/+aKRFmAVXT44S8uEaqOGvjuMxq08wRoJWOiDM12ecwHgwL22oFb2UWE
         zQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkU5wKJfxtzkDW8PCXdDkizcAP5aPgUOWORxsR5FWWE=;
        b=l2JVVwN+FHmT90Z+K0THGq4sdODWyyYt9JfuJyLStQbfRu5EbqyvhWKV1+xXJ1hfyt
         DQNmbYgMrwTBcuB575hhEsogtzWfYm1uXtGGLdqi3kQ30qxEov6cMJhtkEwwyYk5TbBE
         azy9Td85diwVh7vTRAO8pB2e2PVOCeFx23winalVl/RDKqkURrqY7Vz8O5Pb3zTZwfop
         XeB1oQASvj0dis4t6BAGa4ywKNKSXsbheO+wC1cL5/wppR4OywxhE4/1KlSpNOxacZPJ
         sgMrO/pkHlK6gL7S7BUVMuyoH0UnWMePiS92Jp7s0ZX4kyftZdFw75p6BP2nG8CHKKhT
         Jluw==
X-Gm-Message-State: ANoB5pmauA7TYocNXQ5/GXjievD5/TacdVAnw5c2GvoChnEjRg/Op56A
	JTH6Q/+k5oIrIQy+OLePzDij094C/Ms=
X-Google-Smtp-Source: AA0mqf58eHHqaoHQetKBs+G6GJpcGYoMNGvr0CI9VdS4uGUlNMECGaJbIThgyCGDjqEx7EMICcHjyw==
X-Received: by 2002:a05:6808:3185:b0:357:765a:3ce5 with SMTP id cd5-20020a056808318500b00357765a3ce5mr1595001oib.2.1668704434650;
        Thu, 17 Nov 2022 09:00:34 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id s27-20020a056870ea9b00b001422f9b5c17sm666402oap.8.2022.11.17.09.00.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 09:00:33 -0800 (PST)
Message-ID: <d3a895f1-1cc4-3afb-c175-a6aac5996e90@gmail.com>
Date: Thu, 17 Nov 2022 11:00:32 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] scan: make scan requests fail if trigger returns -EBUSY
Content-Language: en-US
To: =?UTF-8?Q?Alvin_=c5=a0ipraga?= <ALSI@bang-olufsen.dk>
Cc: =?UTF-8?Q?Alvin_=c5=a0ipraga?= <alvin@pqrs.dk>,
 "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <20221117152155.2310412-1-alvin@pqrs.dk>
 <878e8c89-6754-af3b-6d2d-9195a920d728@gmail.com>
 <20221117164634.7fjgx7rbzncwqgb7@bang-olufsen.dk>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20221117164634.7fjgx7rbzncwqgb7@bang-olufsen.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Alvin,

>> Or are you setting up a second interface out of iwd's control?
> 
> This.
> 

Ok, makes sense.

>>
>>>
>>> If -EBUSY is returned because another wdev is scanning, then iwd won't
>>> know when it can retry the original trigger request because the relevant
>>> netlink event will arrive on a different wdev. Indeed, if no scan
>>> context exists for that other wdev, then scan_notify will return early
>>> and the scan logic will stall indefinitely.
>>
>> So I think the way to handle this is to make scan aware of all interfaces,
>> even foreign ones, and consider restarting a scan request whenever a scan
>> finished notification on a given phy is received.
> 
> Yes, I also considered doing something like that:
> 
> - have scan_notify take notice of all NEW_SCAN_RESULTS/SCAN_ABORTED
>    events;
> - if a scan context is found for the wdev associated with the event,
>    preserve the old logic;

I'm not aware of any devices that can invoke multiple scans.  It is always 
limited to 1 / phy AFAIK, although that might change in the future.  So really a 
scan finished / aborted notification should be treated as per phy and not 
per-wdev.

> - if a scan context isn't found, then search the same queue with an
>    alternate match function like this:
> 
> static bool scan_context_match_wiphy(const void *a, const void *b)
> {
> 	const struct scan_context *sc = a;
> 	const uint64_t *wiphy_id = b;
> 
> 	/* Find a scan context on the same wiphy, as it might be held up */
> 	if (sc->wiphy_id != *wiphy_id)
> 		return false;
> 
> 	/* It should have a request pending... */
> 	if (!l_queue_peek_head(sc->requests))
> 		return false;
> 
> 	/* This means the next request is worth retrying */
> 	return true;
> }

Yep, something like this.  The wiphy work queue would have a 'running' request 
and if that request is a scan, then that's the one that should be restarted.

> 
> - then if such a scan context is found, we can reset the scanning state
>    to SCAN_STATE_NOT_RUNNING and call start_next_scan_request()
> 
> If that sounds semi-reasonable I can draft a patch and we can discuss it
> further. One theoretical shortcoming of the above is that it is not
> "fair", i.e. if you have multiple wdevs on the same wiphy then their
> scan request queues will be fully drained before the next wdev gets a
> chance to scan. But I guess it's OK.

Not sure what you mean?  Internally iwd operates on 'logical' scan requests. 
These might be broken up into multiple actual scan requests to the driver, but 
each logical scan request is wrapped by a wiphy work request.  So multiple 
logical scan requests from multiple wdevs would be interleaved / scheduled 
appropriately.

But yes, I think what you propose here is the right approach.

Regards,
-Denis
