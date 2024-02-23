Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6218146E76
	for <iwd@lists.linux.dev>; Fri, 23 Feb 2024 20:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708720000; cv=none; b=KhZzLvy7xcpyR8u7oxjw4bxznH1ltHpTp4YqeMjQuimPuXW5amhQCd5NuRsUQLLHFYWxXzIBuzQc+vXmK6TJNfwy9cwHp79ouWJJD3TGpHEQv82QeAH7BsD8XFJeagrSxatqP0jJ6QIb1EpeG9It+9GgIRuvUxdxi+PjMg7WmD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708720000; c=relaxed/simple;
	bh=ohLr1YDArVPCn9JfyncHNU05p9m3pvljlsYiDvqH5ms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWfuk1Hpl8lxogcN9R777UgXwP5Q9RBU5S29c7e/4GEYv8g3u8UM7v1muQPr10mL8rjtHuns3ws5xJRsSC2L1jyfu9Li75Oo57Esd2lNjhOQ7X7yGMTwuj/Ld+ZXnDsCnbEMHCRW50nqSHLBQWi+d6bqYcdVGCQ1f+O3wLI2xWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4C6fpt0; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4C6fpt0"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-214c940145bso378924fac.1
        for <iwd@lists.linux.dev>; Fri, 23 Feb 2024 12:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708719998; x=1709324798; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fOLmbJQv+0UQzzb4bpMtp0T0k1gV74b98soVSUV0530=;
        b=Z4C6fpt0ClFtXuewe1S/rmb5NYj19P6uduEBUioaDmE8I+SaOLY1/Ep2/UyzhPMoca
         KA7/S5SBdduUDerP8SNulZHNiGCT79j3N/u022zBXipTeG30+NMeu0SISC5QP6VWFZZ0
         2gcOe5dQz5Qanhn0Y1eKJ4iqiz5wFfVSvaYfCTltez0A7sYnvNXW+LPiY4FdXyTRy12H
         qdhdR4pGlfp6V8N6GVZB7GoP7Kz/oTUxGrwZ0LmzPgyA01/JGl4RSobVZmby1/Me/fib
         dUvwXWwwLHshu6J4VcG+zeUF06oo7UqAKzpWWX9ioIBi7NuVSk/jwbJ7G2qabxIMn+OO
         hbdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708719998; x=1709324798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fOLmbJQv+0UQzzb4bpMtp0T0k1gV74b98soVSUV0530=;
        b=Iy08o7AZHFaFVGqdWVrq2Oz5MH1aUSI6WE9b6s64u/ny9kRQY/vG1BjgF3rTQL3EsC
         NPlVLDrZegFdKVpxhdFo/DnCmLmNAgTlyhupaAFJnS1zfGuEtoHo+Jva33xni1BHLBBj
         aBXsiOQ0N5G+U5jZ//UyYcaU6uIWp6YLJuGNretiwcwOFuCGpWYcJkN3VS4Mi27XCy7Z
         JAbzPVqn8CCqWoXIpk8G1JMtK6JH2rwICfm6AT4zlZc1ywJQqJsHHsgVoyH0fPs9jePg
         +Bik3+BAupi5QFj8QPU3atHqAWbqp2YpawK0HRFJlRP8gN9PoWKPvFeqrF/U0x4wXLpJ
         wCIg==
X-Gm-Message-State: AOJu0YyWYUOyH0FMzYBa4a+3ZmdwwfYnR7XuoCgAodrRXhTvzOUEQ8x+
	d+oNEX7AaFfgdp0wC7Vea8cZEvTKM4mOzjHlJ9OmgWNBG0tzPo/bSpjiBTgU
X-Google-Smtp-Source: AGHT+IFa1ddU9wrQCe1Mo9kKzO2CT0Z9uwSkziuXMQhaMJWxW3RYGKQaCk+V+oLtx2D7YvHf9f3kGw==
X-Received: by 2002:a05:6871:4d3:b0:21e:9b56:737f with SMTP id n19-20020a05687104d300b0021e9b56737fmr988748oai.19.1708719997800;
        Fri, 23 Feb 2024 12:26:37 -0800 (PST)
Received: from [192.168.1.22] (070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id ds21-20020a0568705b1500b00219e6770b34sm3675659oab.24.2024.02.23.12.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 12:26:37 -0800 (PST)
Message-ID: <f411612a-3d8c-47c8-abc1-41dda98e7732@gmail.com>
Date: Fri, 23 Feb 2024 14:26:36 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Unable to connect to eduroam
Content-Language: en-US
To: Michael Yartys <mail@yartys.no>
Cc: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
References: <njvxKaPo_CBxsQGaNSRHj8xOSxzk1_j_K-minIe4GCKUMB1qxJT8nPk9SGmfqg7Aepm_5dO7FEofYIYP1g15R9V5dJ0F8bN6O4VthSjzu1g=@yartys.no>
 <c935faa9-b90e-472a-917b-4cfd64c9d7f3@gmail.com>
 <oNiRr7aqwSLhickml0qZlRg5tAZ_r_d5KphKztkhii6KjSMvQ0-pYjNo-8NujElHLPJoc9ho9v8X3zD71jQ6O5pdzdTXqFF1T0x2dBQ9Oc0=@yartys.no>
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <oNiRr7aqwSLhickml0qZlRg5tAZ_r_d5KphKztkhii6KjSMvQ0-pYjNo-8NujElHLPJoc9ho9v8X3zD71jQ6O5pdzdTXqFF1T0x2dBQ9Oc0=@yartys.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Michael,
> 
> This is my config. As you can see, the first variable is set to yes, but the second one is not set.

Okay, CONFIG_CRYPTO_ECDSA should be enough.  I can't dump out one of the two 
certificates you have.  Do you have the CA certificate?  If so you can try running

	ell.git/tools/certchain-verify <ca file> <certchain file>

and see what happens.  If your only change was a kernel upgrade, then I would 
suspect sha1 removal as the culprit.  Boot to an earlier kernel and see?

If it does turn out to be sha1 deprecation, then this is a bug report for your 
distro and upstream kernel folks.  They need to stop breaking uapis.  SHA1 
signatures, while no longer secure, are still widespread.

Regards,
-Denis
