Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A26257E
	for <iwd@lists.linux.dev>; Thu, 23 Jun 2022 20:19:24 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id c3-20020a9d6843000000b0060c2c63c337so336618oto.5
        for <iwd@lists.linux.dev>; Thu, 23 Jun 2022 13:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=bhyzO4uQYfGKTR6CvUGtrMWpFArhlHEV6q6n+ycSa+0=;
        b=J+J9CitMuinoZXC0dHGt0YzPp0IdAvory3s6jZR5INedX83JXBfDzdcB7+LdshtMk1
         es6znpcFofLMPc2vGJP9nNyEqagDgcVBrmK2kgi2kLHYHeWv7tm2J750btfZQSq2l1RC
         dfOFstIovBGVdGlIpKRZz0rsKdPaJen5fptX2ci/nWO+rIX1MD0fqjZ4jYEwt6oYGFEj
         za/je3i8cyVknadbfVmsCgYvYqGsBfwjKDPB839ukS1tIjd56Wiox/xKtEz0jp10WZ2p
         sS17bdoLJj0BkbuaDu4H7pVCI7J+Ehq+q5QGUAvBf5y+xJU255EFGoZ6C1cO5GsqYzPA
         Hepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bhyzO4uQYfGKTR6CvUGtrMWpFArhlHEV6q6n+ycSa+0=;
        b=qFHjR0jzk0P26dXZgsXoiAx8H+VEbC/vF5EP7j9zvGh4z+MCYM7CtOTZxMUDOQM+hz
         SbuG5WDEUCuBZau1BhKg38gyl2lYwJAqt5DHGbr/c4rJc3fp+cMU/XCDSd2ES+FGkphW
         SUhcQTso7R2aQL/mjIX+A/6aOQmrRM7fQ6WHvmKUyHMAH5yd/9uD1RlJ6s5+WWC/ciKH
         Gf3eR0VJGmLi1AwHg4Wwlp//ktJxj0BhN80TMiZy6O96LfhaUFrJ0krQmI3vQ/63V+OI
         Mrz0TBDL7pQHM75i1jCzyp1cnmKUgYAkgBU78dgh/L3hvT0bTF6g3Z6Yry4BeHunrvHE
         EB6g==
X-Gm-Message-State: AJIora8e1YlXzxlfRmGb0SZokjeCT/tQGb76VNOp11f+NXCd8F2SenIp
	nXJ0zfx3egpJFXxz4Rpkup2ZKUe3g9f1/iB2
X-Google-Smtp-Source: AGRyM1v1HN9gzOsQ7UrEvI9m+EIkDRp34rNxoOOpyRkPnhqmqR1+OakTdyv1ldr0XGdgqNNGC5WnFg==
X-Received: by 2002:a9d:70d5:0:b0:60c:1b16:9710 with SMTP id w21-20020a9d70d5000000b0060c1b169710mr4472465otj.285.1656015563517;
        Thu, 23 Jun 2022 13:19:23 -0700 (PDT)
Received: from [10.0.2.15] (cpe-70-114-247-242.austin.res.rr.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 4-20020a544184000000b0032f75714af1sm46793oiy.18.2022.06.23.13.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 13:19:23 -0700 (PDT)
Message-ID: <1783ffbe-ca43-f3d1-12ac-5ef0aa96048c@gmail.com>
Date: Thu, 23 Jun 2022 14:58:36 -0500
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
To: Jesse Lentz <jesse@twosheds.org>, iwd@lists.linux.dev
References: <20220622194142.213135-1-jesse@twosheds.org>
 <20220622194142.213135-2-jesse@twosheds.org>
 <312b2cd5fdede0d7fdd7f45aeda5919e9b22950f.camel@gmail.com>
 <CKXNNPV68RR1.3ROOO4K1DSKL0@laptop>
 <4f8abe30-e9c2-0a35-a913-d67c3242ec3a@gmail.com>
 <CKXQZJ5G2LJO.1IJRN5WMBF3DY@laptop>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <CKXQZJ5G2LJO.1IJRN5WMBF3DY@laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jesse,

On 6/23/22 14:07, Jesse Lentz wrote:
> Hi Denis,
> 
>> Inferring the state is fine if you can do this reliably.  One problem with
>> optional properties is that once they transition from 'defined' -> 'undefined'
>> there is no PropertiesChanged signal that is sent (or rather you have to look
>> into the invalidated_properties array of that signal).
>>
>> We have been designing our APIs with the assumption that many bindings wouldn't
>> be using this invalidated_properties reliably and added another point of reference.
>>
>> For example, Station.ConnectedNetwork is invalidated when Station.State goes
>> into the 'disconnected' state and thus not explicitly 'changed'.  But the DBus
>> client can infer that Station.ConnectedNetwork is 'undefined' at that point.
>>
>> But maybe bindings have improved over the years and we should just rely on
>> invalidated_properties being taken into account properly?  If so, that would be
>> a good argument to make 'State' optional.
> 
> Hmm, I wasn't aware of that. I can only comment on the GLib binding,
> which works reliably as far as I can tell - it supplies both changed and
> invalidated properties to the user-registered callback, which gets
> called in response to both changed and to invalidated properties.
> 

Ok, good to know that this works well.

> But if other bindings handle it incorrectly, then I suppose there's no
> compelling reason to make it an optional property.

Maybe I shouldn't blame the bindings as much as the documentation.  This wasn't 
a widely explained feature at the time we started, and this project is getting 
pretty old.

But yes, maybe it is easier to just make this property mandatory while all 
others can be made optional.

Regards,
-Denis
