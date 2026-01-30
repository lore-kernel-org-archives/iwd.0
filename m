Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E0430F92D
	for <iwd@lists.linux.dev>; Fri, 30 Jan 2026 14:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769784520; cv=none; b=uN8devqeVi3DTEtHON7cth1xZQ2IQByClMrDTK6zP/q6l5WQSwUJy8/WBaOxa/nkuEEgKkr1PyjF3tst7Lo0wuVEBearf8cfjOhNo7e/GmpycwLqjBMVCDEocheqZ83I3G58QTR7o5JazHNo0LvPMaoRPmg0t8N+aftLgitMybI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769784520; c=relaxed/simple;
	bh=S4RI9KOR2rVbp9z3DcBz6R8UM1ZrEsOCFM6oM3Z+Ygc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JbVfuWOfXQ6gs1b8nh51id3yDM7kGw+8oHJqS0f+nRZmwt9sqLf3facKx3d/CRNTyF1poK/+MfHFGJH2mKjbveSVCl+Di+3XX8wiLZ/WAShHpzD5KAlhRZDqqOSk9tAUByY36wWhN+dUOmhfTNFUOTV5BTgNcOjuK1gmNNpxb1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpXgTgv4; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpXgTgv4"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-505a1789a27so7586391cf.3
        for <iwd@lists.linux.dev>; Fri, 30 Jan 2026 06:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769784518; x=1770389318; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j/i90HbSjRmXXsVwzmSNoHl84spW2KPgtUkrM/krN/w=;
        b=cpXgTgv43KE5K37fuUHSDXCfn6NY+JeVEbqnjCOPBYWvkTnXyzcYBpmMsuL2ZMGCnp
         POOgEcF6E+jJz3eEI0i7+mWgDvuz9V+sTXrVCRw8z+wFasgsowpEAoJfLgZ7tuMgLMc2
         XUs94NskWd5rMiAsvsWZEVgodu0VRzNjQqY9jyx2nP+Mv9Dq2Cmgg1ODuj1c1mQYLFsd
         FK1M7HY24ESF5+clxsufzKakVBoUkghoWL87QZshri6zUNdGW6b9UP3x1PCFkdBJJey1
         te803ed2KGzu5v8wlb1wZrIXUPMxaq5VtJtZLXKKPbAMH+SMQgDws7UMN4mM2eBWt2lN
         Fppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769784518; x=1770389318;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/i90HbSjRmXXsVwzmSNoHl84spW2KPgtUkrM/krN/w=;
        b=clfNrqTH/CAYOqm67Hmt/qG3I2q4nY6wxW7BZHp4BHjZwvz/qbvwzME9t1/V0vubpm
         Ee8pWWAq5Vd6siC5IAKWc/DLdShZcyvbpgnK6olwKw/6tWDqYr+CLQ2OV2Nxn+qSJI8m
         yy4InMoFQX+rgAcUxPO76Vcnwr46TDz3CqgBAOi3CNlvBAAYSVqs/ySrCw8bOF8Lgvsk
         YfG5TkmkMsIWnBP5xtNy6enPJ74R8dY61L/kISQGBYLltFD4o9dlDNcm133K2zYbCgcd
         rRohi/lyYYk+4uQSNRJR6L6002W6oaYu6VLrr39gVtdmMB16cSBZMMi5YY/Fx8pG/z6s
         ME0g==
X-Forwarded-Encrypted: i=1; AJvYcCWJ8EQnzqRY7Vu8TESwx4qC7lqQS2NLQjxf1yimQOjWC0NeJben9PHts+S85rRNmo60bik=@lists.linux.dev
X-Gm-Message-State: AOJu0YwhQdrFjbX3ve0+3hhRAqR+cr/Ouc2zBIaBi4VQdxqPw3ZaepSz
	oZ+UnDTPD343JPyyQf0kyURyGQJ2YU49Vannv0KH8PsnzEm3OOM9xjCAfZoLrA==
X-Gm-Gg: AZuq6aKkPeyQjeBR3JM2JqTrNHYaHBLxzEqgOOOdmzcNGTIX/+WJoxlKQq2fcrWNRhw
	5jyLhoWtK7ioP36BiucCXx95C1Cfpm1Aq7l8HJs1f69dxsGpPd8tKYYC5YpBIi/oCSQQLP5KrPG
	/HX2qn9nzbIszeuIufK9wBqao1fjDh0b/1SbRuZK7qzN7evcufXCWx2p8gmaG9pzqgmYPkazjqo
	rME9bIsOCn+6nk9iccgYssehwFHVHuGaJkZwOxEiK2HezpZnIqRVcrTZRjKT/bYjtwnBdXGYJSr
	NJgEAvTw15+4tFVUnFO0hMIbZduRke5tQluvTwUSdVZQGxoQNJEAX9jwIQoaeEvZt7PyTs01tax
	JtDQzorKTMd0Q+aMpyoFn4chun1+LigzWb/qGOCHfhlZfJ1Yf0f8oEN3OQ5IE2wf3hm9M8ieUpj
	L3aZErFOirEEQ=
X-Received: by 2002:a05:622a:216:b0:4f0:21f2:cc98 with SMTP id d75a77b69052e-505d2264d85mr37739841cf.50.1769784518534;
        Fri, 30 Jan 2026 06:48:38 -0800 (PST)
Received: from [10.201.20.209] ([71.181.84.66])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5033c585c55sm51080701cf.11.2026.01.30.06.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 06:48:38 -0800 (PST)
Message-ID: <3d09fed3-9728-43e4-840d-13052b5fbf6e@gmail.com>
Date: Fri, 30 Jan 2026 06:48:35 -0800
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is there a way to manually force the security protocol with IWD?
To: Bryce Johnson <bryce@redpinelabs.com>, iwd@lists.linux.dev
References: <CADXxVSJ5FrxYs_s_tz5y6LeGbVLnCgJP3YO8TQEXTnXs+rFuug@mail.gmail.com>
Content-Language: en-US
From: James Prestwood <prestwoj@gmail.com>
In-Reply-To: <CADXxVSJ5FrxYs_s_tz5y6LeGbVLnCgJP3YO8TQEXTnXs+rFuug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bryce,

On 1/30/26 6:43 AM, Bryce Johnson wrote:
> Hi All
> We are working to get our product through wifi certification.  Our
> testing company mentioned there was several negative test cases that
> were failing where IWD was connecting anyways because it would decide
> on the security type based on the AP.  Is there a way to force IWD to
> use a security type that is different than the AP so it would fail the
> connection?  Can we disable WPA1-only connection or force WPA2 only
> connection?

There unfortunately isn't at the moment. We do have a "developer mode" 
by specifying "-E" to IWD and this seems like it would fall into that 
category, support would need to be added of course.

But I'm somewhat confused (and maybe this is just poor test cases by 
WFA?), why would you need to certify that IWD fails when using a 
different security type than the AP? A client should not ever use a 
security type the AP doesn't advertise support for... This feels like 
its testing the AP, not IWD :)

>
> Thanks
> Bryce
>
