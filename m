Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD14A1FB2
	for <iwd@lists.linux.dev>; Thu, 23 Jun 2022 18:09:38 +0000 (UTC)
Received: by mail-oi1-f176.google.com with SMTP id k24so492666oij.2
        for <iwd@lists.linux.dev>; Thu, 23 Jun 2022 11:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=SyHPwpmOffiLs1cOb9yJ+GN5ORT1ZoKlOCFUdQrmge4=;
        b=K2ah7dbVmeSFu99t+zzPVSQvoatGyyFDSacWjx21o/98JDRhcfTegVnUsP3mDLtaKi
         /2bjYp4MGC5U/KmapJWNsCxygweJKF6t/jZIlutvXNDXfv6AhpGJtvaK00faTOR2zp5j
         YuTKRvc1BihfOD8kI1geyz7W7j8TnxP69WP/gkeaDBqcoclfe+YCIXN5RXxovNZl3tGF
         nGS2bKA6YQBbpRpsFYP90oOYlNVUzW4DxVj5J0losIg9Lk5ibMG9+/XzNehxHNHPVD5s
         pmpegVeOICkJXfNmV/FN9MkA9vVix1DiqunObUc727GcaSx7UA/COM9Uj6BMNATNgEn0
         eyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SyHPwpmOffiLs1cOb9yJ+GN5ORT1ZoKlOCFUdQrmge4=;
        b=b9TrTCCsknSGKAGG8i7BGaS6T8FMFHSUkkKhe36LZOWVTcIqK6crx4s5BAiJQoIhfE
         tPMfoqdj45ND0tQILIUlM8ZLJS4kgqWCrkXzKJd5pGUEFoiB8juD2ZT4SOrD0+XYhMJJ
         RJ2s1CvKy6CPYwq+9RsiY7UMmIM5KQVZGV6fUFMfsCeWFXvMcgtuHNDZpDUEpwB1sCud
         omKpN4g62/SZG0J9UPhbQg5YRmhmg0TSIEe41Z6qQgXsWFzOlCE3VHj1KfwhtxBX0zq+
         cm7krrjv6gFm8HF7ia0+NNrHrne2xjyS7IbGe+8T/DRzxW7ORdNZRf1QKrThCqyEndz4
         ZIyQ==
X-Gm-Message-State: AJIora8smnE3CzTv57bAOGKloMTT9LulXyThL3+1cDX2AOGEVI+BJeJc
	hTHxlZ6iOCUZjNnrcCZk5mg=
X-Google-Smtp-Source: AGRyM1umZJswmNAEGJS0y80jntoxD8d/x4rFM5tluc5SN6VHr4rdAfhCzPfJy+9UVCyljiAGm8MkaA==
X-Received: by 2002:aca:dad6:0:b0:32e:80bb:9c2 with SMTP id r205-20020acadad6000000b0032e80bb09c2mr3038179oig.106.1656007777850;
        Thu, 23 Jun 2022 11:09:37 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 37-20020a9d02a8000000b0060b9e65c00fsm180936otl.25.2022.06.23.11.09.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 11:09:37 -0700 (PDT)
Message-ID: <4f8abe30-e9c2-0a35-a913-d67c3242ec3a@gmail.com>
Date: Thu, 23 Jun 2022 13:00:47 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH 2/2] doc: Add State and Role properties to DPP API
Content-Language: en-US
To: Jesse Lentz <jesse@twosheds.org>, James Prestwood <prestwoj@gmail.com>,
 iwd@lists.linux.dev
References: <20220622194142.213135-1-jesse@twosheds.org>
 <20220622194142.213135-2-jesse@twosheds.org>
 <312b2cd5fdede0d7fdd7f45aeda5919e9b22950f.camel@gmail.com>
 <CKXNNPV68RR1.3ROOO4K1DSKL0@laptop>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CKXNNPV68RR1.3ROOO4K1DSKL0@laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jesse,

On 6/23/22 11:30, Jesse Lentz wrote:
> Hi James,
> 
> Thanks for your feedback.
> 
>>> +Properties     string State [readonly, optional]
>>> +
>>> +                       Reflects the DPP state. Possible values are
>>> "presence",
>>> +                       "authenticating", and "configuring".
>>
>> I think a "stopped" state would also be needed.
> 
> As a user of the API, I can infer that DPP is inactive if "State" is
> undefined. A non-optional State property with an explicit "inactive"
> value should provide equivalent information; would you prefer the latter
> approach?

Inferring the state is fine if you can do this reliably.  One problem with 
optional properties is that once they transition from 'defined' -> 'undefined' 
there is no PropertiesChanged signal that is sent (or rather you have to look 
into the invalidated_properties array of that signal).

We have been designing our APIs with the assumption that many bindings wouldn't 
be using this invalidated_properties reliably and added another point of reference.

For example, Station.ConnectedNetwork is invalidated when Station.State goes 
into the 'disconnected' state and thus not explicitly 'changed'.  But the DBus 
client can infer that Station.ConnectedNetwork is 'undefined' at that point.

But maybe bindings have improved over the years and we should just rely on 
invalidated_properties being taken into account properly?  If so, that would be 
a good argument to make 'State' optional.

Regards,
-Denis
