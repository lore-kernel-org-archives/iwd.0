Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D1F15572E
	for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 18:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713207005; cv=none; b=jM5JgCf6Xnffr6yXCZZ6Id9PmVr1U0+sYPfVmLzSVGmdSIHG0ddJcVY52R3YHZeTgvPMfp8IMjXw4pFyFIUpGBhHPK+LBdvDRxipL6oJHxLUb0BhbY0VIgHA++XzCo3TN92LRIeqQvzUIZcc7t44NZbnbsp9acuS1i/MO71pRks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713207005; c=relaxed/simple;
	bh=Yj++LhSkogHTwCH8cRSRVsHHwNIcnWVPhkqDBvFC5oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=uGbBcmvNDQqBoPFo+ngd0sWxjInrg54YhQi2Z9/td/+1SZug/smscAulrU2HU35qGHnOuq69YZbGLZnpdqCPNGneEsZDHX9BMs285SDbYO1UquVPYpve5dvzbSyWeHgi2GIgSrk1s/Q/ouPd5hxWcR5rSXjetFmc0rAuoTXQ5gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N9yjzfCJ; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N9yjzfCJ"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5aa2a4dd0ffso1730253eaf.0
        for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 11:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713207003; x=1713811803; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FlS8dEew06DTnYFPyiOGGbcIaK5ZumzZyunJbqeWg4c=;
        b=N9yjzfCJLSea4pM/DOaX0LEiifxL73NTAC8nxrSBbUpRfmbPbVm28N6OC4lzxuFDYz
         RDX5lou6j3BA7gzr9srMVzAKHXzukbfT2WWymHhDksvzglkWFokXzdwr4IN05oGBw1Ys
         oLPaxkYPxVklXU/ByWuTNiZtAtBlVuTK5nujhF8jCZAKirbl1DQhN44V+2QhFZciOgNM
         Yy9vs+DvRpoPApSuR+E0xDb+SJRNgpLYu+EhLw+O3rVgBx6CviXKeBpv+Yil58sG64jw
         toHvaO1UrhEid0Vkz1DgcGyTEhyYqcwltDe95h7WoHLnZtEU+C/u32agBKsOo8Dycx1z
         el/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713207003; x=1713811803;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FlS8dEew06DTnYFPyiOGGbcIaK5ZumzZyunJbqeWg4c=;
        b=IC9ZSqmHmJUdiVc9qQ5HRAm5GsXxWxNzKkaOu5vRueKBmNlFA4di56c2q88fySn+Tf
         SnXSCfnmNl6eMWkqqEhLmpOnwbrQTNOLcPn+aNDdgwwJUXzUHDKFwspPzkI339BhlfJD
         x3eDiSHy1/VZbCkbj5ttCXLAvepzTkMwBDU3TiRb3tXqzopoNrZrA0txkwYQXNXNuiN4
         o3DNoUwA0R9cxuRc1MzsQiU+YA9qioTLThA/FDyibzIDFd+XrI/87ck0sRpl/rwtuAjw
         SsMy/+lGRTPwXXAKrE4Ub0PL4vpTC//T/ar8ZDZosd/0kPTjtCo+hstYk1oQdKQpNBft
         uzEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs3vy8sMzGWpMJvIwm/S1qHIz6wFyD+uItf8+6YA58EPP5vGA5ioJ339yBR8MKTgBKNJgaa2EU67c2Da0OO9JnH1j7
X-Gm-Message-State: AOJu0YxqE78BghHxPZQ13jvHmZDJKJl9wccHrY+E0mnMjwftHy4AEO0K
	gIz8f4PMPOY4UAZA/uKUgZK2uT9+wOjrxp0jbZK5JaMQ1jyY89An
X-Google-Smtp-Source: AGHT+IG5MocPbMXuDuUBG7VsxBkGieeieBZWXSKuV4oJe9c105uctoBLM8He3g082r72i6rLBNFkEw==
X-Received: by 2002:a05:6871:81f:b0:22a:278c:817c with SMTP id q31-20020a056871081f00b0022a278c817cmr169489oap.14.1713207003576;
        Mon, 15 Apr 2024 11:50:03 -0700 (PDT)
Received: from [192.168.1.22] ([70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id lv26-20020a056871439a00b002336a4cc3basm2284596oab.21.2024.04.15.11.50.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 11:50:03 -0700 (PDT)
Message-ID: <558f87c3-7f6f-4c9b-9ff0-42f261f13ef3@gmail.com>
Date: Mon, 15 Apr 2024 13:50:02 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: NT/VHT errors filling log
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, KeithG <ys3al35l@gmail.com>,
 iwd@lists.linux.dev
References: <CAG17S_OZt84p8HQ4E189+VTMssSrDBDXNzeMUT_hZb=jbuKE6Q@mail.gmail.com>
 <7978cd1a-8122-4b6b-9e38-b7d65a9c393e@gmail.com>
 <8c99082f-fa0d-4c9f-87ab-e49dc9e0f497@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <8c99082f-fa0d-4c9f-87ab-e49dc9e0f497@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 4/15/24 10:15, James Prestwood wrote:
> Hi Keith,
> 
> On 4/15/24 4:24 AM, James Prestwood wrote:
>> Hi Keith,
>>
>> On 4/12/24 10:41 AM, KeithG wrote:
>>> Group,
>>>
>>> This is on a Pi5. this is with the 'current from git' build of iwd.
>>> iwd-git/now 2.17.r0.g468cecdb-1
>>> These are new errors which are showing up in the log and recur a lot:
>>> Apr 12 12:14:17 pi5 iwd[1537]: error parsing HT capabilities
>>> Apr 12 12:14:17 pi5 iwd[1537]: error parsing non-HT rates
>>> Apr 12 12:14:17 pi5 iwd[1537]: error parsing VHT capabilities
>>> Apr 12 12:14:17 pi5 iwd[1537]: error parsing HT capabilities
>>> Apr 12 12:14:17 pi5 iwd[1537]: error parsing non-HT rates
>>
>> I added these recently as well as a small modification to improve fallback 
>> behavior for calculating the data rate. This isn't coming from the driver, but 
>> the scan results. Apparently APs sending invalid IEs is more widespread than I 
>> thought. I'll need to change this to instead maybe a single warning, or maybe 
>> hidden behind an env var.
> 
> I sent some patches to the list which should help. You may still get a warning 
> for HE capabilities though, if APs are advertising the malformed IE.

Can we find out what is causing the errors?  Is it the low RSSI?

I rather we added a L_WARN_ONCE or L_WARN_THROTTLED or something instead of 
turning them off.

Regards,
-Denis
