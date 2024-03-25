Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E4D4DA0C
	for <iwd@lists.linux.dev>; Mon, 25 Mar 2024 18:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711391017; cv=none; b=nR05fFQ+UEm6C6+uQ3OP/TkS8FtB6OUsOvu3NOPPI3BKuQun2KzqpopA6oiZG9pklhmkfQqeB5lgMuVkE7G/68EzNeQiyF10fGrZeNS+REDicBHD4tuPILrkRPCAZr2j+/GMY9HQEVIw1W6jGOOL9T3zeTkRGxAoxmXuDxJQ8Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711391017; c=relaxed/simple;
	bh=qJDZL7DquodAG9tfc07Z8yAhUA61if0NExLV1L4lYq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Q+zcGfw5QVqZybKAZeVznqLJyiqony3xHyiMviGuurCYWjC1STwtWeNu4lcA8PeepfMChz7XRRIoxc48srVQpe3b8ze1+eF9IPkilm0Sx+aSw23+qFjhK0eAeN7C8ehyspRvq2ZAOsdumUvXRWv47XJq3aEiCepKlCCond8RX7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UTE5jEFp; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTE5jEFp"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-696719f8dfcso20199556d6.0
        for <iwd@lists.linux.dev>; Mon, 25 Mar 2024 11:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711391015; x=1711995815; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zQKnKK87UWkJ3DkilZ5gOKrUGUOKsuvAwHfUChxQRBQ=;
        b=UTE5jEFp5wop10TIY1BWZLuj3woV0xkmO7bz9zd++dRdqiADbxZEzinqvZNuuU/prJ
         YlC0XAQR0QDoRzIWEWTVIJMaJxKB7N27qBq1y6GeSsNZ04weNlwhZcLI2vJrcg/dj7S3
         mBXs4EDFD+u4eB7jTvnHNv/WaY0TonwMdzULpa9QfktuFaaC3f4JK8zPAGZi28wEGKSl
         /kZsEyVdm5+Le1mlbCl/Gh7ge2SaENNYEQPXqSlW1aFA+M/py34KHDCiK9oo1jbHylK1
         oZq+jQDzVgb0gdsesFJFIEPjKlCe7c3R5/7fDYFqlUIW8Kp48vKieBXNf2jxRflL4neq
         mQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711391015; x=1711995815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zQKnKK87UWkJ3DkilZ5gOKrUGUOKsuvAwHfUChxQRBQ=;
        b=HnUxSIDAA48c9rUMcO2/OR7/vEYZmsW2Vj1vZKcdFLk86bieMl16pD+oYpAcGCvFid
         AfnvEs+kwM0UVx2iMn0MD+O6pwDF4+YyJKc2D0Giac879i+1Gig9dyJb1IQgrDp3XvGK
         TYq9GIb3/YjeQizB1Cv3B4U5TYRDQRx4UOw76VzP4NLWXdrW17DdkuSvcXR0XC+Jh3Vj
         lh4y+dc7GqYEQD7XoiCDcPMjbA1PRwz2j+GP1qO+/+u5Hn/uWrNCi6wWSoAiri+pNQh/
         WJ/tLyH4Sb8Qv6EYcnn+y/moUJnM2qxYb9fatjt1M6RJHQW/AOBmYSzSWcx/XlIy9/uo
         oY9w==
X-Forwarded-Encrypted: i=1; AJvYcCXa6IH8zQhlNZuRm+QE9v3kq4LWhhuAl7PZM9ArY2D0t21bv8TQyUyqxIa1ihHytHOHQYPDtPN76PtLaWn91ajdvwhR
X-Gm-Message-State: AOJu0YytiNZyhsNvR+z/+ftOaylCzt4bzMCJGB3ZtkrHTELuKMH6fFJt
	TH8Yi6/tSzOP0mC2K3BZkOR+stz93y64qzvO9GY7rWI6j92SD4H/
X-Google-Smtp-Source: AGHT+IEb7arKaF1C3vQuWiACELTcYhPBXhFf3Kw6kIwwJGXaZd8meIHZ965WAF78EFTKR6RAJujqMQ==
X-Received: by 2002:a05:6214:2586:b0:696:7134:fd8e with SMTP id fq6-20020a056214258600b006967134fd8emr7432576qvb.63.1711391014730;
        Mon, 25 Mar 2024 11:23:34 -0700 (PDT)
Received: from [10.102.4.159] ([208.195.13.130])
        by smtp.gmail.com with ESMTPSA id z15-20020a056214040f00b00690c77505bdsm4374103qvx.37.2024.03.25.11.23.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Mar 2024 11:23:34 -0700 (PDT)
Message-ID: <bba319c4-6e65-4809-99d4-90019b89a89e@gmail.com>
Date: Mon, 25 Mar 2024 11:23:31 -0700
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ios hotspot fix
To: Jeremy Whiting <jeremy.whiting@collabora.com>, iwd@lists.linux.dev
Cc: Edmund Smith <ed.smith@collabora.com>,
 Alvaro Soliverez <alvaro.soliverez@collabora.com>
References: <27b427-6601b380-b-46ef6f80@167641064>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <27b427-6601b380-b-46ef6f80@167641064>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jeremy,

On 3/25/24 10:26 AM, Jeremy Whiting wrote:
> Hello,
>
> In recent testing it has been found that when trying to connect to an ios hotspot some messages are missed by iwd. It seems to be a timing issue, doesn't happen every time, but does happen often enough to be a problem. In testing the device fails to connect more than half of the attempts.
>
> Ed Smith has created a patch that seems to fix the problem here. I've attached the patch after rebasing on iwd master.
>
> Here's a bit of background and explanation:
>
> iwd has difficulty in connecting to iOS hotspots as of 2.7 (and not
> fixed according to our testing as of 2.16 - latest at the time this is
> done). This is because of several factors:
>
>
> The iOS hotspot does not repeat its initial EAPOL challenge, where
> most APs will.
>
>
> The iOS hotspot is not reactive to EAPOL-Start (client request to be
> challenged); it sends exactly one challenge, and then the connection
> times out.
>
>
> The iOS hotspot sends its challenge very quickly, more quickly than
> iwd is prepared for. iwd is not ready to receive the challenge
> packet before the association event is fired by the kernel's wifi
> stack, but the iOS hotspot's challenge packet consistently arrives
> before this.
>
>
> This patch moves iwd's frame listener registration for EAPOL back to
> the authenticate event fired by the kernel. At this point, the
> necessary details about what kind of connection we expect to have
> (e.g. are we an AP) are available, but it's not possible for any
> plausible EAPOL packet to arrive yet (because authenticate requires us
> to take action - EAPOL happens after association, which can't happen
> before we respond to authenticate).

Out of curiosity what client hardware are you using to test this? The 
early frame handling was added to support brcmfmac IIRC and as I 
understand it the EAPoL frame wasn't actually being sent too quickly, 
its just that brcmfmac was sending the events in an unexpected order.

So yes I suppose this could happen. There is even a comment in 
wpa_supplicant which seems to indicate the behavior your talking about:

https://w1.fi/cgit/hostap/tree/wpa_supplicant/wpa_supplicant.c#n5498

Could you resend this using git-send-email so the patch is not an 
attachment. That makes it easier to comment. Looking at the patch the 
first thing that jumps out is you register prior to processing the auth 
event. If there was any failures you would have registered for EAPoL 
unnecessarily. Might as well move the registration until after the even 
was processed successfully.

Thanks,

James


>
> thanks,
> Jeremy
