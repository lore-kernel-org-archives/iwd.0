Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD32429CE8
	for <iwd@lists.linux.dev>; Tue,  5 Nov 2024 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730838864; cv=none; b=fGjK2pO8egPYlHvn1MssVClB5rIQGQd5Wfa+Ia9QcrvmIFkv6RXeCly/o2TqVeXoEJNTRS0M/mz1dTcLLpO1WiSXHIQ+rzEwEG7oAbETICXve7iefvEgXvkMnZ6SEnjgSM0Wj/SUArcvWGti9H0+u8bN7G9KOAxiXVdS7h3cxK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730838864; c=relaxed/simple;
	bh=8LeS5eQ1CI30aYWQUsXEgxRzGyRxe/mfTOw9c2V1oog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jN8d3b54QCtMTYANDzIG7lS43utbNUx5gUHCSfvQXtcZoBrZZqIRpIFE7Ei59kD8I9jMts0Y+qVpsh9rQmcvWYuI5N6t8LWhYWSFMCHKhOIvC830lXfSYS028fBN1kbKWaDIyLVteB5qXhN1Bo9y/ywzyrLhSm/Mom1ihALUJIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FVgLGni/; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FVgLGni/"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2884910c846so2610758fac.0
        for <iwd@lists.linux.dev>; Tue, 05 Nov 2024 12:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730838862; x=1731443662; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D5hV59ckvTBmlwN/Ud+Xw6k28MVgI25rBHv/G8c9J1o=;
        b=FVgLGni/+x+SOqtxh+6Z2+BrjTJF6j8qaANMTAeQ9zklozGHAHRjayFWXZf9tXDEua
         K877a53+ZnOPu65nzBh6k6B1UPNJFaMFoGntUnP9r47kWUVjp6+OpAJC/vXfzBNloZil
         N05+J5Y+B6owjZIrpt96UcHEfcb+eUoo4iYn4eYNX5ESaDPc6DCAwAJk/uLQyg3QIOKa
         O0DSQq+oC5izsdWBh8KH4R8Mj+/AtBC1V4WYaaB3laqPPg3URAaS+buVv8ZazsjOuqyO
         CvlB64wDdyYJgGg/KNlWlLi1UmtqAsK1GiUcZ0ISgLxWW00YOSFgg/Z2RcNtw28kdJ4w
         KVlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730838862; x=1731443662;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5hV59ckvTBmlwN/Ud+Xw6k28MVgI25rBHv/G8c9J1o=;
        b=vbhfrWEfXWGpJf2QUeUcO12qjhsVJuuywGMwHeSW4TQgWCxbkVLYFsWuMo/rkeRy5I
         O9c6N/4BHC8Duj81hdSYmvsxGQALq2VTTETNWnBs+EWrEd8spl3QVYO+pD3ZZqHN5Y5q
         nO3ulFxQLyolY+GYkly0RPHuH9lwkPSKiieJQBpe6hYq/1+9iMHSbX7MBhx96Joq/ZvL
         wewGDOI3ThIYT9TvP2jfNpc7GzSjEq0YTVDCRiD+ERHvrqF9TYX2oWjV7W2fvLak5eYp
         IhUx9348fIbSqiQxyGmjtO3bPG3AwRSLyAaXiTGKYRR6RaXj6OkmNwl99NeYR5nUeSPc
         sZdA==
X-Gm-Message-State: AOJu0YxQWhG6p3a9h/vxgkdn2TEZEJ/cgmcA3VcxbTJyBf60sekpEdz8
	Mh5So0yJ+pyLHX0qPPLs1g7W5VGDR9pDKRrXdLhljYZ8URYINsOovSR7qg==
X-Google-Smtp-Source: AGHT+IGUkFcW1lRCfAdocDvawgwSyML3gEg7zNfAtX06U4I7dAa6QCxCmP4bXso7kRrtOYQXAVkSXQ==
X-Received: by 2002:a05:6870:e0ca:b0:288:a00e:92dc with SMTP id 586e51a60fabf-2948442bbe5mr18991846fac.2.1730838861809;
        Tue, 05 Nov 2024 12:34:21 -0800 (PST)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 46e09a7af769-7189cbc2b8dsm2625768a34.0.2024.11.05.12.34.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Nov 2024 12:34:21 -0800 (PST)
Message-ID: <62de8616-96e1-431e-b867-b1f1a6c8f14c@gmail.com>
Date: Tue, 5 Nov 2024 14:34:19 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: timesync when using IWD stand-alone
To: Martin Petzold <martin.petzold@tavla.de>,
 James Prestwood <prestwoj@gmail.com>
Cc: iwd@lists.linux.dev, Harry ten Berge <htenberge@gmail.com>
References: <bb7c6c59-b5f1-4a22-a168-83ccfc5406a3@tavla.de>
 <CAN+yOboCgTLninh255t6Z61S1PaKXjS0yj1HTx5LU9c5dzyS_g@mail.gmail.com>
 <7d815327-bf9b-441f-a736-a2f3a651112d@tavla.de>
 <8958134f-25f4-45c6-8285-51e27afdd8e4@gmail.com>
 <bb02480c-97aa-4833-86ac-eea737db4f41@tavla.de>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <bb02480c-97aa-4833-86ac-eea737db4f41@tavla.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Martin,

> I disagree, a FritzBox guest network is a very common setup (we have several 
> testing sites and this is a selected common setup). Port 123 could also be 
> blocked in other guest network setups, seems reasonable. So, it should at least 
> be noted in the documentation (single line). If it is required, no idea. But 
> IMHO stand-alone IWD is then nothing really stable. We are not talking about 
> devices connected by cable at a fixed place. With wifi they can be everywhere, 
> in any potential (common) network.

It should be fairly trivial to integrate iwd with timesyncd.  If this is 
important to you, please consider sending a patch.  Documentation patches are 
also always welcome.

Regards,
-Denis
