Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE74D84D24
	for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713207662; cv=none; b=dR0WJyy/8Gw4Q67E/hecJtePODQo/2dhVLCSFoCrA7PxtBFFsZGHn33lCWGKZkvy8Kr3XiwGYnbs++M0l6ymM2X65rp6WzqCFYGXbr7SDqwJSNi9e94zMPv3PwlEOwZXrtdQvqmuW5Otc3I6TM763AewMW5iEuVRFXu0oGTiYNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713207662; c=relaxed/simple;
	bh=d79oqTiOdF5nJDvLjxalZArrxbXx3vpT+cxstFUGSVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u9Gs+ehVwteDRY+NnBpDPKvjuI1+4fo4q0yTDQ08bYgRjPAozlTACL2qpprxsQqwSPvz7IrX1wQbParOGPYhzZuABZ6IgAGZgks67ncNuR5uimcetYFa5/4N9EGti3OeRMPHrp4NJBAWkjLp7D/ZQnQ6jgYgLv7PvJ+mXijL8uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdlWCIWd; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdlWCIWd"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bbbc6e51d0so1665602b6e.3
        for <iwd@lists.linux.dev>; Mon, 15 Apr 2024 12:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713207660; x=1713812460; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xC9DcD6pzD0XuIsjTQT0N5LDT/9y8eCyT/5llERiK9s=;
        b=RdlWCIWdLi6vwzh+PsYhnyj4iHxQ7wmvqKp5qcy6bXDjRSYx3Tr8lxsLp1jbzk6c1S
         quJeJQwaem6II3hnDsEtcY66SP8nJ03V9VSoBmD7Z9U+NRWMkIzO7JHLyrkrCSEegdRy
         R2X2hBJykq2HJiqfl9JT3kaKpqbabrGbJ+SwriL7l6QEadvACOVEaGljKUn36dmpDPwn
         g6Fttvi1NFrdUZ4JvlkoeWy+YFPHtua/jVsoup5oftapHz+7C0Ovt23L8srJinyKaoKf
         z8RHw4U4dqwxGZEe7QXARmZkc/hHROel0dC1F8NTH0LXF2ASd0djHT0qSDiV0dx1JqlJ
         yotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713207660; x=1713812460;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xC9DcD6pzD0XuIsjTQT0N5LDT/9y8eCyT/5llERiK9s=;
        b=wWSa5QBnZozBbWrltcmMCVVCTzl5RUWQ3RXYn3QWeFRtxj3BmlecIF8SQOuBBRpvgn
         crTSruHbOB+Re7zzw4txV4yGnLeSn6IVj2/3JDKkhD368EN45c6J2rl1hpRlFBp76/hQ
         CpTMwfrUTpIQr+6d7WVztv2hq8zRz7SWgfS3KWGWlKBXlygRwL2EOe33jKXvQq5qOEa4
         Q+KZVwRbZnlC0oQsi32zMTzLe2BMNgKuunc+7jQf9Z1s0QBv23vm85amb6uQtfMg9+4J
         NmL3mhNgY3p5G3vam/gnflB7fZgqdNsxXjw6CDNLE0VLE4UDKCOJwJ7fvinrMdEuIwit
         6bxA==
X-Forwarded-Encrypted: i=1; AJvYcCXS5Mk1XkxHGpTklOonzMh1JAjVpZ0+YlHYJSUqwlf1Rsdo+lu+7n7N5UxbdAnrfaLgvUc2XaRXrNG027P5rorjROGa
X-Gm-Message-State: AOJu0Yx1BECDpJxMGHhYLxZnJzCd0qVRUVZl+HSDTJUCggNk75I/W23E
	MRo4r+yHXM+q6Z77i4LX1XlOHRb7/xZ7/w5lIaVaJhdC/gRkizTz
X-Google-Smtp-Source: AGHT+IGr1bQ3p2+wcUIgsy5vS1bZFCrWplINbxzQ2BidDJwCcWkFa4r3rZNQFOvj/CunzLXhnsNT8g==
X-Received: by 2002:a05:6808:3a4:b0:3c6:942:4dcf with SMTP id n4-20020a05680803a400b003c609424dcfmr10479602oie.37.1713207659653;
        Mon, 15 Apr 2024 12:00:59 -0700 (PDT)
Received: from [192.168.1.22] ([70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id k11-20020a54440b000000b003c60ef0b865sm1728072oiw.35.2024.04.15.12.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 12:00:59 -0700 (PDT)
Message-ID: <e7b50887-b02a-4e5f-beb3-34e6b2a6a532@gmail.com>
Date: Mon, 15 Apr 2024 14:00:58 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] dpp: prep for moving AAD within
 dpp_append_wrapped_data
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240327151957.1446149-1-prestwoj@gmail.com>
 <ebcfd870-b9a2-4215-b652-3008d3d2b6b7@gmail.com>
 <a8fddf49-da5d-4fc8-9084-34b2ed40cd2c@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <a8fddf49-da5d-4fc8-9084-34b2ed40cd2c@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi James,

On 4/15/24 09:02, James Prestwood wrote:
> Hi Denis,
> 
> On 4/2/24 8:10 AM, Denis Kenzior wrote:
>> Hi James,
>>
>> On 3/27/24 10:19, James Prestwood wrote:
>>> The AAD pointers for DPP are specific to the frame type. This is
>>> currently sorted out by the caller within the respective frame
>>> building functions but its quite unreadable. There are some comments
>>> but lots of magic numbers. This should be moved within the
>>> dpp_append_wrapped_data utility but the first step is to make the
>>> frame buffer continuous. This will allow the entire frame to be
>>
>> continuous -> contiguous?
>>
>>> passed and dpp_append_wrapped_data can calculate the AAD offsets
>>> itself.
>>
>> I'm a bit confused as to why?  Whether we have an iov or a contiguous buffer, 
>> the end result is the same, no?  If you want to omit parts of the header from 
>> the wrapped data calculation, wouldn't you just break up the header into 
>> multiple iovs instead?
>>
> I did this to prep for patch 2, which uses buffer offsets and the frame type to 
> calculate the AAD data. Its true the AAD data is always broken up into header 
> and payload but I didn't want to use iov's because we would then have to assume 
> iov[0] is the header and iov[1] is the payload. A single buffer makes it a lot 

TLDR: Using iovs this way was actually the intent.

Long time ago Andrew even had a set of patches that implemented / formalized 
using iovs for the various layers some time ago as well.  I don't remember the 
exact details now, but the idea was to be able to pass iovs around and share 
buffers without needing to copy data around.  I think the implementation had 
some problems, so it didn't go in.

> clearer: we can minimally parse the frame, find the type, and calculate AAD 
> offsets. With iov's we would have to check iov[0] for the type, then use some 
> offset in iov[1] for the second AAD chunk. This then requires the iov's be 
> exactly what we expect, which isn't a great API.

Agreed, iovs are not ideal.  Long term I would actually like us to implement 
some sort of sk_buff equivalent in ell.  It would abstract some of this and make 
it easier to manage head rooms / tail rooms for the various transports we use.

> 
> Yes, passing the entire frame also requires the buffer is exactly what we expect 
> but documenting "the frame must start at the action byte" is a lot better than 
> "iov[0] must be the header starting at the action byte" and "iov[1] must be the 
> DPP attributes".

I'm not sure that having offset calculation is really any better, particularly 
given that you have to make some rather invasive changes first.

Regards,
-Denis
