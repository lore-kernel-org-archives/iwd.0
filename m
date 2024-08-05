Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5CD13AA45
	for <iwd@lists.linux.dev>; Mon,  5 Aug 2024 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722868447; cv=none; b=hFAaLwvHbXz3THVxFz3JEokfNDWWtdoIJLwa6GhPFCqLs7OGEuEQhSg0FiHeqfW8i/Eu9Zdp6LLUv6Cpuv38PlR2iFfLoiKlXWgr7YOJKr0aMGFgwLILyCA3aAZdoUWNx54yd27nvEgUbI3ir6b/7Zg53LuVXc+/N/70Wi7FlEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722868447; c=relaxed/simple;
	bh=9eQjYYZV1u6S+A3EVYwBWrDf35UjxTWFp7KIVOhfyFc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kiZGRPdovDC/ma1HDdNbg+ek97Di/W0fJ8YGFM70Dzf1auP+Te+nxFuWrTe6c+6k3gIMOhEU5pMklEB2Sven867jgrfnZoEiY/EBRd7L3uus1AIkzbl/7nLHJX5VAIMnMJfMuMXu/D1JXGmgpM6przTymwBYg14P0vR6USJ9YCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lDtDAFCm; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lDtDAFCm"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3daf0e73a5bso7273788b6e.0
        for <iwd@lists.linux.dev>; Mon, 05 Aug 2024 07:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722868445; x=1723473245; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CpMG5pD8L+UzDZ53GLndzizsEOxJDufFlB1KSrBLavA=;
        b=lDtDAFCmiDJPuXtMeMyDXVPcwkyVEof8JbE0l9NJJLGs4L9699H0tQXBnUckiG3aMV
         J7B4r1hhzZo8bW3IAcVybZaYLUaf8iXnh9K/8f7t26/dCdtT2EqI+zdCQHMz+vVfzPF0
         m3WXc771C6isQANK4JV54e6yehLpkLj2efV3zWcJ1APpAatJuIOrdDqlcC89Fh6Rb6cu
         92oHHsvIkp3T7+mmwndhBlBKr+zOYM04ipKj/7utSyAf7pORTjvR3QOuyQNiLCVitq5d
         0/ugJX9FxOukbTrp4DeVmIeuXm3NrS8YS1CjN3qlUOo0vSRQJnDsZGZrxJomcB6PY7F8
         M1MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722868445; x=1723473245;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CpMG5pD8L+UzDZ53GLndzizsEOxJDufFlB1KSrBLavA=;
        b=ntiH35mFKz6X1L6g9dLpA1yDFqZU3BE+E24FhDZh6dDOxYnt8dgcsAWqMbLGbggioJ
         mteNZxq6OpuMQyPIikQTGx9+O7fz2CAkC1+KwtlL2Oe4jjiMmBLb4Bp6g3d5Q61vDv5/
         b5EdfGOxvTQ7y3ziaRw/c1OiKyJi9LNO5Y8JOpAvh5YolujkB+W9lZ1QnGH2yJpuTQZ4
         LcjfmhIgzQJJxO38n8ITNYu8ddEr2YoJg80noFwgJsxiL9ynzcz+kUxS+fvQuqDNAvBP
         h5n2qlYG/Bj8hx4CwwAiodB7vAwKFwxWRP5/qompGM//fSKyRIZ3WU2feg0sfdpW3DNK
         oBKw==
X-Forwarded-Encrypted: i=1; AJvYcCX1qkdeILVjpT/XHStSnbvRzj99UZeahUb7mYCGIuS8RREOL3YOdvu4ZXgTSEdm0nItmItEAVa/ddssDkpAMuBOTB1G
X-Gm-Message-State: AOJu0YwWtcT84AKntua+6mHXY9iP0IieOVbeR8lSbReyXW5vW6qL9L91
	nk7mgnBIFjMCOQuyU0rf4cZzeVYxo7PqLJN9M4xvGixZ5lyJXFep
X-Google-Smtp-Source: AGHT+IGxnxA3BdAvzE4BIuDjSiTPMlS7G5F4nI+/d/QyNxJBJRVe5m7UlKsc3cey6vRzIOpJXZjSYQ==
X-Received: by 2002:a05:6808:1a24:b0:3d9:dc98:c84b with SMTP id 5614622812f47-3db557fdc87mr18165384b6e.5.1722868445070;
        Mon, 05 Aug 2024 07:34:05 -0700 (PDT)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-70a31d9dfc8sm3055697a34.5.2024.08.05.07.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 07:34:04 -0700 (PDT)
Message-ID: <bb6dedb8-3baf-4d3b-9109-d193e47b09e3@gmail.com>
Date: Mon, 5 Aug 2024 09:34:03 -0500
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] netdev: Simplify FILS handling in
 netdev_connect_common
To: James Prestwood <prestwoj@gmail.com>, iwd@lists.linux.dev
References: <20240805140721.57518-1-denkenz@gmail.com>
 <20240805140721.57518-7-denkenz@gmail.com>
 <4bb34106-49e9-45f1-a3d2-cab6329f2029@gmail.com>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <4bb34106-49e9-45f1-a3d2-cab6329f2029@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi James,

> 
> Mostly just an observation, but the switch block is pretty much just checks for 
> SAE now, and the default build_cmd_connect case. It may look nicer to just have 
> if/else if's for:
> 
> IE_AKM_IS_FILS()
> IE_AKM_IS_OWE()
> IE_AKM_IS_SAE()

Totally agreed.  I have taken out the switch in my pending patchset, but wanted 
to get the easy stuff out of the way first :)

Reminds me we should add IE_AKM_IS_PSK() as well.

Regards,
-Denis
