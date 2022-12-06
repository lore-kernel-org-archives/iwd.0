Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA1327722
	for <iwd@lists.linux.dev>; Tue,  6 Dec 2022 17:57:31 +0000 (UTC)
Received: by mail-ot1-f43.google.com with SMTP id t19-20020a9d7753000000b0066d77a3d474so9747226otl.10
        for <iwd@lists.linux.dev>; Tue, 06 Dec 2022 09:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y1p3U3jjlhDy7k/Q7XSu91LB2InqrnRUCuveYum7YmM=;
        b=brqQHcIWz1ODiZ6pom338aG4H106TEPpDA5QmSHqTTQmBfXNSxfR03f9VswkbA6Tzj
         i8JYOQ+c0u13CBMwk2D8wD8ptVLHmErFZtkNCRkL0PNmCLLbT9WmufVOB5A65fdPdVnO
         FBwMS6SS3OQue1ohrTfCFCyMrjbqFQ4ZEzn79/gssVY327Th/HQdKTXjnCoBjZKtI37m
         amWq8G0jyZuFft1rQ3LVRCQhNggmc8zENew11jEVm0r6WbaLVostA9EVjlKgzECNldnr
         53JdQ/CQFrdgz/UUCkT3Gnu3rb2JERV9Lq+UvUQ4RHRf/OhG8hd35f9CfjhW6D6TaNqW
         PRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y1p3U3jjlhDy7k/Q7XSu91LB2InqrnRUCuveYum7YmM=;
        b=pGYXcB4vx3JRTbNaZEI/AKtN+GgIA9fSV2v83m6zIpHnn0afwahol32HTcBXETE3zp
         yVVJ430+j2ONH3WCBcRbdX3K3jVq7VbegrMJVXslo9jcWjPTjS8OCJZVR4xQxJtXSAeO
         z5rNj1Rph3suJtdF4ouzms9r6bxIIfuNSM4z/UfXK6D6DIWbjHht3P7TRDhHsLjNTsN1
         MvZoDkpgQjgdrHC7Mklt01szsrI9Zv30m1gsotdWLX2UA9JBoIgsBpm0aOy3rUqhPkEr
         PTKGzp448KNysHfoKfltWMtvvRFeIdZ1DY1er2QuyoFgjEmQzjxmHPk5qjZtWf6yQpkp
         ZdfQ==
X-Gm-Message-State: ANoB5pne5ksUG9I9xUNtRsoN3gmFAl2HvTjbIPKlmZZv0/+SgSBNLRvO
	9SoldS5ZFGOlwjmGj1BFv+g=
X-Google-Smtp-Source: AA0mqf4tHAMnJThLedb3IR5MTMI581LL8FNO+2ofSCPqNUNnCh95Ljw1C8VmUKYUP/ZDdm5deXX00A==
X-Received: by 2002:a05:6830:6009:b0:661:c2b9:11df with SMTP id bx9-20020a056830600900b00661c2b911dfmr33749662otb.76.1670349450660;
        Tue, 06 Dec 2022 09:57:30 -0800 (PST)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id r25-20020a4aea99000000b0049ef7712ee5sm8102329ooh.11.2022.12.06.09.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 09:57:29 -0800 (PST)
Message-ID: <8e5cca8e-5520-7051-d0d0-3a9cff14767e@gmail.com>
Date: Tue, 6 Dec 2022 11:57:27 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: WPA3 SAE passphrase limitation
Content-Language: en-US
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: iwd@lists.linux.dev
References: <CACvgo51HZVDcmvHiaZK3XFJyp6LUGRFEM+G=5j1--av=XWni+w@mail.gmail.com>
 <d2df3b8c-2b0e-b587-bd04-4892e4e84f5c@gmail.com>
 <CACvgo53tii9sLJFcmsPymJ-8HBZjvwpuBR4DNKYLNVdoGFY3_Q@mail.gmail.com>
 <37ab408f-c9e6-7e9b-0088-d7e5fed08241@gmail.com>
 <CACvgo50MYLmr4HKH_Haue5b_k2-2eagDUhy=-bv_2hn6WciPZw@mail.gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CACvgo50MYLmr4HKH_Haue5b_k2-2eagDUhy=-bv_2hn6WciPZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Emil,

> 
> To distinguish WPA3 only connections, from transition WPA2/WPA3
> connections, one could store the profile as "$BSSID.sae" files. Where
> the usual "$BSSID.psk" ones are preserved for WPA2 compatible
> connections. To preserve backwards compatibility IWD could:
>   - if the AP is WPA3 capable (regardless if it also supports WPA2) -
> try the sae profile
>   - if the connection is unsuccessful and the AP is WPA1/WPA2 capable -
> try the psk profile

This would be a much more invasive change, especially since iwd deals in 
'logical' networks.  Not sure that it would makes sense to store settings about 
a logical network in two separate profiles.  Possibly?

But... network-centric settings (see man 5 iwd.network) would need to be 
duplicated and synchronized.  So what you suggest becomes a lot more complicated 
to implement.

Supporting non-ASCII & arbitrary length passphrases for WPA3-only can already be 
accomplished by setting TransitionDisable and DisabledTransitionModes in the 
network file along with loosening the passphrase validity checking rules as 
discussed upthread.

> 
> The above have some obvious caveats, but overall would help with:
>   - providing clear distinction for the user about the connection types

Both WPA3 and WPA2 are PSK networks.  And really, most users don't ever need to 
see/edit the files in /var/lib/iwd.

>   - keep connection type specifics where applicable - no more
> PreSharedKey in .sae files, no SAE-PT-GroupXX in .psk files...

Possibly, but see above.

>   - roaming between WPA2/WPA3 AP and WPA3-only AP with the same BSSID,
> yet different passphrase

So in theory it is indeed possible to have a different passphrase between WPA3 
and WPA2 APs in the same network.  But I don't think separating the PSK networks 
into .psk and .sae profiles is the answer.

Adding additional entries for SAE-specific passphrase and passphrase identifiers 
might be possible.  But this only works for static setups where the profile 
isn't (supposed to be) changed by iwd itself.

When we ask a user for the passphrase (and eventually write it to disk) we just 
don't know whether the user entered a 'global' passphrase, 'sae-only' 
passphrase, etc.  So for now we assume the passphrase is 'global' and apply 
passphrase restrictions accordingly.

> 
> Mind you, I'm not sure if the last point is allowed in the spec. So
> please take all the above with a healthy pinch of salt.
> 

It is.  It is even possible to have 'password identifiers' and use different 
passphrases per password id.  All sorts of complex setups are possible.  The 
question is how do you make it 'just work'?

Regards,
-Denis
