Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A2610E7
	for <iwd@lists.linux.dev>; Thu,  2 Nov 2023 01:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rl9/Fndh"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3b3f6dd612cso258955b6e.3
        for <iwd@lists.linux.dev>; Wed, 01 Nov 2023 18:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698889189; x=1699493989; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V1ZuIrOEhF+dzYcWPlDLFm0Wf+JPHehMSyLlf3ID+Zk=;
        b=Rl9/FndhxRbtWntymw5i0XHgatANa3btupOQwc2Q8hmd7s8H1WNZfSSAaLChIKn7st
         R5UjIY6Qli6NaidgfblpiWm5VJHG/BePUhp47YF3JqvfT5yIBFfVObiMgB+QN7vCdSyC
         ii8PLrS9l0D9o9byozOJzzhXXWdj4NjB8JEVOUgTSFfQeTLuTE1+MV0D6czhyk5WAT1i
         o+qyZDTHeQEw6k1wu52iZUIEFR78ZbYdz0MYtyE6+UdqgR7FWqtJtufobnT4ytkbYlv/
         Niwg3yXBaqNAi5LFKwTounID+aHkykHAiNFJR7/bEF98to5uGKe6jgGZrmRkAneasfch
         PzlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698889189; x=1699493989;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V1ZuIrOEhF+dzYcWPlDLFm0Wf+JPHehMSyLlf3ID+Zk=;
        b=aqMiDB5koRvpvWb7S1PxTHXFomobPyuL/7pMWBrrTrnUJpWs6LaN2PHzv4h/NujgKl
         EKaPuIHZe0RZAXPTkExHcQS1n/TMjXl8hKov7x9ga/37HZMG2StIOSrISYvw5yNBS7i6
         aG3qaUE7DlIvgac40ZMLMyQLISVH2IePX8RYIC36sexxFbYwinNA22AdQ4PcYmByrQAC
         qnbDag8sS0Rx0zgLC/RP9UwsCtgvgks1141TX+/810d+7BpdWQ8g7XYidVUtxGYMAilV
         TzMYrIj5aSfn/Ynh2wZsNAkWTEhwFVvqGFqJZWa0IKur6V2lzoQZI5lOjhE742s+eXV/
         O75w==
X-Gm-Message-State: AOJu0YyexEwPa2iKCauxi7gSnbfBaTK/1TytU5M81BPHh80INDcxZRvp
	sjeQVD4UwdZKAnV7G6L1yuPztZ0VcMQ=
X-Google-Smtp-Source: AGHT+IEhEtf/GGsMdJKli9s4D1Bh16pBOz9baWEUE23yScyruyHtZGtpHyiscpUVaRQaF8jX7eGYng==
X-Received: by 2002:a05:6808:30a0:b0:3b5:6b60:9120 with SMTP id bl32-20020a05680830a000b003b56b609120mr6418055oib.24.1698889189146;
        Wed, 01 Nov 2023 18:39:49 -0700 (PDT)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id p12-20020a05680811cc00b003af569ad2c6sm401626oiv.3.2023.11.01.18.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Nov 2023 18:39:48 -0700 (PDT)
Message-ID: <d5be907b-5790-42da-a17d-6ded2f9562a6@gmail.com>
Date: Wed, 1 Nov 2023 20:39:47 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] Packet/beacon loss roaming improvements
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231030134837.452957-1-prestwoj@gmail.com>
 <b5138012-c4aa-40bd-892e-5b578a29ade4@gmail.com>
 <0cf695c9-7abc-40e9-a6fa-fdd10589839b@gmail.com>
 <fb8dfeeb-3f5d-49d2-8a4e-063b4933d905@gmail.com>
 <70935a8f-1f38-4e9e-8d77-40179c2b31f3@gmail.com>
 <68d50637-4b8d-4690-bfac-e379e1044492@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <68d50637-4b8d-4690-bfac-e379e1044492@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

>>
>>> If the kernel has a hard limit after which it expects the connection to be 
>>> disconnected, we can start a timer for 2-4x that limit?  Looks like kernel 
>>> uses probe_wait_ms parameter for this with a default of 500ms. Is your setup 
>>> using the default values for beacon_loss_count and probe_wait_ms?
>>
>> Yep, everything is default as far as nl80211/driver options.
> 
> I found an old thread I asked on linux-wireless back when I removed the beacon 
> loss handling [1]. Johannes explained that behavior did apparently change in 
> order to support power save (your memory was correct).
> 

Hah, funny.

> I identified the behavior change with hwsim, and apparently took his word when 
> he said:
> 
> "I'm pretty sure real hardware will behave just like hwsim here, albeit perhaps 
> a bit slower"
> 
> And I never added "proper" testing of beacon loss, i.e. block several beacons as 
> opposed to just tearing down the AP. And this appears closer to the behavior I'm 
> seeing in reality (AP not going down, just dropping beacons).

Right.

> 
> So this is my bad, I didn't take into account the situation of beacons being 
> dropped but then being picked up again, or the nullfuncs/probes coming back 
> successfully.

So the question is still how we handle this properly.  When the kernel sends the 
nullfunc / probe request, are we going to be interfering with that logic by 
initiating a scan right away?  A scan would force the device to go offchannel, 
preventing it from receiving the AP's response.  Given that nullfunc should be 
extremely fast, maybe we should delay any roam action we take by a second or 
two?  If the AP is truly lost, then we'll get disconnected soon after the 
LOST_BEACON event.  If it isn't, then an extra second/two is not going to make 
much difference since the scan should be limited and quite fast most of the time.

Regards,
-Denis
