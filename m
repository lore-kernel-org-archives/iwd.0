Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AEC2F3A
	for <iwd@lists.linux.dev>; Wed, 18 Jan 2023 13:17:01 +0000 (UTC)
Date: Wed, 18 Jan 2023 13:16:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1674047812; x=1674307012;
	bh=s4/Uhd1fg8WGVj4jjlfac5bY12d7ZTLSJKS1zEIqKVY=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=zBbZ6xx6qaI3jHOZTBUTovCDpfd2GY08vEyRzfLxlDaPUj+47sINtEiT7JjeD5Kk0
	 8BgLHdPqYhvRB34Qn9oajlgkV6mRKvIMnezyLITEmGF8oWgkk6HqHuowvkyImCQS8O
	 wwrwuHUh3aJKXqIzzIa1325WTP9mt39afinva6dzg2MiZE68zEWTYQOaSZqcNyAq+U
	 U2n6fax9B02nNlkGSPje7opBAYAB0AP4Z/raZ5iI+2OEjCLssu/u1ml5HI4sN5QvuO
	 g/wbW4b5yMEMDZ00E7W2G9Eos12dvzv20IHgOKrwphVn8bgfA8bqzyLTPk/keX3hYs
	 UNHv3CO0OuZlQ==
To: "iwd@lists.linux.dev" <iwd@lists.linux.dev>
From: Michael Yartys <michael.yartys@protonmail.com>
Subject: ECDSA support
Message-ID: <-H_hDnis_8eufaXJO7ObNd3y7Tys74ouHJg_A9OVHKpLIOMHWKBaayXV0QC0Ss61b5kZdOPQP5tIU0ySQF1XWgYc8zlQQ9qizmcGNw7JYf8=@protonmail.com>
Feedback-ID: 6588689:user:proton
Precedence: bulk
X-Mailing-List: iwd@lists.linux.dev
List-Id: <iwd.lists.linux.dev>
List-Subscribe: <mailto:iwd+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iwd+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

I've been unable to connect to my university Eduroam network ever since the=
y switched their certificates from RSA to ECDSA. As far as I know, iwd has =
been working on getting ECDSA support into the kernel for a while now. What=
's the latest news on this? I would really prefer to ditch wpa_supplicant d=
ue to the superior roaming functionality of iwd, which is really useful on =
my FT-SAE home network.

Michael
