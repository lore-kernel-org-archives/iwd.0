Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9037B3F4
	for <iwd@lists.linux.dev>; Tue, 30 Jan 2024 20:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706644855; cv=none; b=FWBaAD3uz1ve7BNiW1vYHRpB6Uw6hxL1AaP0XzYn9+K7VZx6NiwfZgvPsnM68cZPWngen43YX4mKXNZMDZlQva5qQTMH0Xngvyom/azeE4/IW0hGDQDgFa99cBZ13kS0yz5/gOc4oNYhv8rSbOjsNiS3c/t8N6HkUB3EFOGWBQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706644855; c=relaxed/simple;
	bh=/E1+Unk6UNcE4irKbul4xB/dYwszBnVMVKZDkYlNwzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Ci3/LHoteaiiutW94iPjL9T3mdgi48izcVKkG7vERJLi0AR9CadAFTh9B6+J6W+UX11xX9MYwEoPZ37CTJwA2GDr4HqV1Q5Fd6xjzoIrIba8gu5nQh0/oLTdusJIch3AdtR4sZGbUpTHZ3OXotDsP6tVypZBGLfq/mzcRa87NJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpHTCC6o; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dpHTCC6o"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-21533959f03so2519039fac.0
        for <iwd@lists.linux.dev>; Tue, 30 Jan 2024 12:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706644853; x=1707249653; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0wNiqjBCHIw6BtVSId10Ku7BzvpezAlEiEaqFwV4P9Y=;
        b=dpHTCC6om3Dqq4G2k0moMsRrdQDR0yqTc69+chbruENx+IjcDr3NVJpxwTWyZiVv3p
         8dmdzJ79vhtQ7RGkdZi79+DigrZbtPciaDNy1jZj+EQ2nDVQJgOTXue9JL1Oy8E2YimF
         +DDXwVY3+CHifBUCHicweZqh0SzEn/uZUJTqpG7PNknrJbG99FoWT13yuKeRgGcNniDr
         tL6z8rJLxZffmENftdLv0uJE/zmsb2qPHvXS4XySOf+hHZ9caE5QQCFlK3csQWX4fJx2
         fc5DfYy7BjViw+kDdIbZ5Sp1Kq2KfdyI0hHukuPQVKHq+fF+yt1axmvPHBYzoSDGEdUs
         TunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706644853; x=1707249653;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0wNiqjBCHIw6BtVSId10Ku7BzvpezAlEiEaqFwV4P9Y=;
        b=INS5c8c6B0yNyV49FW5b6EbvnEmSRLP/OPhXvOzFGwf+DscxXhtpUjfMCG0GqArPzA
         2VhTcFGYYvV7SLDtGAjpns+M2Wv1DU5YB+RCmqv8lC8UZemLvFBCCEp8nZEkOtCJLu1b
         CkPpbdaj0IXC2a8XdfdRcnt/6vd+so8rb2RBie+bpm4gJ4KBT1JsJsbPju+fh1frcsPJ
         KMWnUQP08rZ6rwfwz8ZKoopiasz8T11eROwr+byoFY2Z217WQDxaKb7q1DAkA68hhjVW
         ztDwyA0Dle4Nr5MEelTpT5TuI2wxMpTnPI+h7KXeqglBRajWs3ozh98tDjjy+umv+jp7
         IwyA==
X-Gm-Message-State: AOJu0YyNn69zSN0CSOoy0fuUJ/1utX/KBiOVEJNlVdEzqBPezbHx9Lab
	tvds0kD75pqs8PAhpRSDA6hAyw7EiPw2Gfs1cJ9QDYsyJTDXr+tOLqzP4/yf
X-Google-Smtp-Source: AGHT+IF3zC707VcpBzHYhhiIlKJFxKdJt5pUGPB+Kwz5vRlf8YtRswA9Wpt5/WCl2yfFLJkekw3/zA==
X-Received: by 2002:a05:6871:7a2:b0:215:3392:c020 with SMTP id o34-20020a05687107a200b002153392c020mr6544369oap.6.1706644853052;
        Tue, 30 Jan 2024 12:00:53 -0800 (PST)
Received: from [172.16.49.130] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id pw43-20020a0568713b2b00b002186834b911sm1763124oac.8.2024.01.30.12.00.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 12:00:52 -0800 (PST)
Message-ID: <c8776be3-5f5b-4855-8081-59c0f972d6e5@gmail.com>
Date: Tue, 30 Jan 2024 14:00:51 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] netconfig: limit DHCPv4 attempts to avoid extended
 netconfig times
Content-Language: en-US
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240130175038.77908-1-prestwoj@gmail.com>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <20240130175038.77908-1-prestwoj@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

On 1/30/24 11:50, James Prestwood wrote:
> ELL now has a setting to limit the number of DHCP attempts. This
> will now be set in IWD and if reached will result in a failure
> event, and in turn a disconnect.
> 
> IWD will set a maximum of 4 retries which should keep the maximum
> DHCP time to ~60 seconds roughly.
> ---
>   src/netconfig.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 

All applied, thanks.

Regards,
-Denis

