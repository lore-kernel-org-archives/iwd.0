Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA373DBA5
	for <iwd@lists.linux.dev>; Wed, 15 Nov 2023 19:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QJ6a0IqM"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1f0f160e293so4451855fac.0
        for <iwd@lists.linux.dev>; Wed, 15 Nov 2023 11:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700075232; x=1700680032; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nnm52E9eGlFwWu0iPfaHo6E7OBaYEXIUCjbGyCJB4lg=;
        b=QJ6a0IqMi7yPOi7KA+N0QAHT5CgzhVresz1qtE/ntImfgYRDwxaDqQMFTW2G5wkbJ7
         SUhqZ7xp4f4gnBPaQL8GwP8Rni2SFTieHy3WIJfu7N8P1lBnt0LtIV+3+2F2iz/c/2QD
         Ft9ZF7IFc29EoY4b0gzaMKwQk/iZUKRGM6qk8Q5SnC6iDs6tczVm4eaJ/jrBC0sbmN9h
         WyphC1+43BIhUHwjxZdcMthMAPDpI8ZxTLbt9jWw6wvw8Cl9xidmZzXMgrQa5BxulQl/
         tHpqvCQbM0jtaXTJBLu7pPVWfN93+b4VXL/KcY4GDYM3/mGw14OdjdjOPLt3Qycg2nz2
         9nSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700075232; x=1700680032;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nnm52E9eGlFwWu0iPfaHo6E7OBaYEXIUCjbGyCJB4lg=;
        b=I26NJW/mxQliBpGz5+z212KE2m2QVtByM5VjBUQWHUP/hLtxzzbPzLwjqe//0yUl4F
         ukpkovXeHc0+/cDvexy7+yYQLyexGHzw8EggVm0VeB5LqjSrgW2Bpzeynf02YUpEFtyw
         Iva1i0oWJVb3qzc/gUKdW3xlNg13/Q8yAr/qaS7WumoyNP6+mefDMVmm9wZlHdScCjGb
         JgY3Qip43iyZdY5Os/fU3ZkahX2zaDK0Ks/gLvM8/mgL4TvcRQUaHAV4sNPYBP7hdixP
         JcyeDZK4s5nDN5QwnzNY1XaNX8f1ZIioiz4W0UDDZfIdu5pbb0LXN+Gx4DrU3PFGhFxf
         lg1g==
X-Gm-Message-State: AOJu0YztJn2f8RzqtNZG5exPuv2rRvaPr4qZ8QAkaG29NpLi7Pp+gvdt
	wXhCDgJrQi1k0rFFmcpvlPr9zCE906E=
X-Google-Smtp-Source: AGHT+IH3h/BDXJimqy+0oMMmhCbS1wEqE1GUtWzWLFsrB7DUF2O64jHdDS76m9APaM2fxSznH9Z9Tg==
X-Received: by 2002:a05:6870:b525:b0:1f4:dde5:9434 with SMTP id v37-20020a056870b52500b001f4dde59434mr16918543oap.35.1700075231930;
        Wed, 15 Nov 2023 11:07:11 -0800 (PST)
Received: from [172.16.49.130] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id y4-20020a056870a34400b001e9ce1b5e8fsm1852832oak.15.2023.11.15.11.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 11:07:11 -0800 (PST)
Message-ID: <09133467-972a-421f-ab9d-01dbd37d1f78@gmail.com>
Date: Wed, 15 Nov 2023 13:07:10 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] netdev: Separate connect_failed and disconnected
 paths
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20231115000547.1139157-1-denkenz@gmail.com>
 <20231115000547.1139157-3-denkenz@gmail.com>
 <196053b2-0bdc-41ca-b309-09680343b079@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <196053b2-0bdc-41ca-b309-09680343b079@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

On 11/15/23 12:27, James Prestwood wrote:
> Hi Denis,
> 
> On 11/14/23 16:05, Denis Kenzior wrote:
>> Commit c59669a366c5 ("netdev: disambiguate between disconnection types")
>> introduced different paths for different types of disconnection
>> notifications from netdev.  Formalize this further by having
>> netdev_connect_failed only invoke connect_cb.
>>
>> Disconnections that could be triggered outside of connection
>> related events are now handled on a different code path.  For this
>> purpose, netdev_disconnected() is introduced.
>> ---
>>   src/netdev.c | 45 +++++++++++++++++++++++++++++++++------------
>>   1 file changed, 33 insertions(+), 12 deletions(-)
> 
> LGTM. You may have already thought of this, but I do still think we could have a 
> case where an AP could send a deauth during key setting right?. So key setting 
> could still succeed but station would get notified of the failure via the netdev 
> event (in netdev_disconnect_event), not the connect callback.
> 
Yes, it can happen at any time.  We have some inconsistencies in how we handle 
the corner cases.  For example:

- We Authenticate successfully, but AP Deauthenticates us before we Associate. 
This is handled in netdev_deauthenticate_event.  See 2bebb4bdc7ee ("netdev: 
Handle deauth frames prior to association").  We treat this as a connect 
failure, but I'm no longer sure that is right.
- We associate and handshake successfully, but AP decides to deauthenticate us 
prior to setting keys, or setting station.  Pretty strange case, but should our 
connection throttling logic apply?  Today we treat this case as a connection 
failure for initial connections, and don't handle it at all for the roaming 
case.  This is what is happening in Alvin's case.
- Firmware / kernel can deauthenticate us at any point.  Kernel probably doesn't 
actually do this, but the firmware can?  How should we handle these?


Also, I think we might still have some problems when we connect / roam 
successfully but get disconnected prior to netconfig finishing.  We should audit 
the code and make sure we're consistent.  For example, are d-bus method returns 
and state transitions generated at the right time?

Regards,
-Denis
