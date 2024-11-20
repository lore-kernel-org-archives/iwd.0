Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C76B487BE
	for <iwd@lists.linux.dev>; Wed, 20 Nov 2024 17:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732124212; cv=none; b=OkKlWvnO5nBpyB2qw2P4fOS/sulOSRyuvXEv7hjM+ibm0Lxa/Emv3FAhRr2vbS1MhGaW3lzCilVi85S2WPzU1MiIkL0rQI90B5Qey8AA9Ajfy7a8jsY1x7P85mqbYMXpNc99xdBHN+6qURKhsAFJFCfy9XFXT3XqOJF4ZbOTHnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732124212; c=relaxed/simple;
	bh=ncaXB0Y3lDXjVXIAPAA7kTCUJS1RQy61rJAtoxI+gJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rTia5nbglPkU4fqW6jMutbnaZHouGNr6z8HfOYthFE0UWubqxt9ksUzexINcRMol41NQya0osMWIvuZGtDDgERqxDrA+4GheGY/5WCVycqSqqs6RrhkQSw79tBMvjHV2XEzcfS0SQe3KLHoXue6aExS65LCNflrf0GsY0el4IoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kn9lcyqW; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kn9lcyqW"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-296994dd3bfso55742fac.0
        for <iwd@lists.linux.dev>; Wed, 20 Nov 2024 09:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732124210; x=1732729010; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XgxW10dmnHLaY2prMZe91ui3GZDIqsC6DG1FFCvHt1A=;
        b=Kn9lcyqWo2vrqVtrSjLLCQVLBM47wM5NQY2p8puparVizmJNW4QkKFy5LqgxIQ+6NM
         GnUiKkzrWf/W7QzQ0yiIRMhPt8AMqsTaZUjGRUWNrxNSOAv/sdccSxFpi9hqK0NYO7/0
         Njovs3NScud6hNxi2CGeDB82qE8MjXbWE9z0j3T3C8PZThvsFmOFXlJLkm/KIVBZusc1
         H+ZHyz+yL0mngntzan6wGzwG8eHdKMPtHlupFZf/s4qRQRnvXwPINm5K+1JojHNNWwqv
         86ys6vKJ99CNeLBxmH1RFBAiFk9RjJZ+VFs/AwpVnwFM28MVvXoAQtmuM18w5Lts5NAH
         XiFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732124210; x=1732729010;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XgxW10dmnHLaY2prMZe91ui3GZDIqsC6DG1FFCvHt1A=;
        b=G2GlzPURLW5VItIpq+Xks0jJr3ftQKAXBOU49QT3XmudArsA3dTVLJzP2Wfvizpj7l
         Nb6bUTmMu1Xi27XyDOG9B2cXbSV5qrCYKSbuynTAXdI6kBpdU+kI5y3W3qQxkF3angwk
         UpG9f7ww9XcmIak4kR45bzCMTs4YguputXwcBtmaAhsOXtKBTYaRw0n+QlXv/aeyAOeM
         utRb4+Y2MiaQoWBybk6NMGCkFYYO0wiPIIbfotfeJ8IibxU55S6Wv/Ije4MOf+yAsJz2
         OlZ//CWENm7lKg8HDJ7x62z6a9DLjEF8oAj62u5AYOVSWRe7Z4S/uNO4Oy1ZvYeFym8e
         zsjg==
X-Forwarded-Encrypted: i=1; AJvYcCUgzcORxpActrejzuIMni4dysjl0KE5sEHlGJ1Rd75xsHCPr6WLmtHW1VDRp1nHBPKn+4s=@lists.linux.dev
X-Gm-Message-State: AOJu0YzzLw5/fUhPvA1nxCsxzPQ/hl+c8Z/zBZAXQm7KCIz+WxhxoIVL
	N1HIwIGyXZNVVzLBYyCgF80buFw2uSUUwPlfh5zEV8c5vDt3VhG6
X-Google-Smtp-Source: AGHT+IGBz9jUwsinlxAO+lOK11IDNz7JQShvffXkZRvP0ChJqs5OekbUXQB761Kpq0FyLfaXjTVN4w==
X-Received: by 2002:a05:6871:e28f:b0:296:dd30:e90f with SMTP id 586e51a60fabf-296dd314296mr3187542fac.16.1732124210235;
        Wed, 20 Nov 2024 09:36:50 -0800 (PST)
Received: from [192.168.1.22] (syn-070-114-247-242.res.spectrum.com. [70.114.247.242])
        by smtp.googlemail.com with ESMTPSA id 586e51a60fabf-296519399f4sm4291881fac.24.2024.11.20.09.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 09:36:49 -0800 (PST)
Message-ID: <471879b9-6524-41da-9e69-946aa4a78649@gmail.com>
Date: Wed, 20 Nov 2024 11:36:48 -0600
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] crypto: fix -std=c23 build failure
To: Rudi Heitbaum <rudi@heitbaum.com>, iwd@lists.linux.dev
References: <Zz3YsU2pn-HtWvXn@c8d99ad60702>
Content-Language: en-US
From: Denis Kenzior <denkenz@gmail.com>
In-Reply-To: <Zz3YsU2pn-HtWvXn@c8d99ad60702>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rudi,

On 11/20/24 6:40 AM, Rudi Heitbaum wrote:
> gcc-15 switched to -std=c23 by default:
> 
>      https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=55e3bd376b2214e200fa76d12b67ff259b06c212
> 
> As a result `iwd` fails the build as:
> 
>      ../src/crypto.c:1215:24: error: incompatible types when returning type '_Bool' but 'struct l_ecc_point *' was expected
>       1215 |                 return false;
>            |                        ^~~~~
> 
> Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
> ---
>   src/crypto.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Both applied, thanks.

Regards,
-Denis
