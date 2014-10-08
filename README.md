# MiJ2XML
Convert newline-delimited MARC-in-JSON files to MARCXML collection files.

## usage

This program takes three arguments:  
<ul>
<li>sourcefile: the path to the MARC-in_JSON file to be converted,  
    defaults to meta.json in current directory</li>
<li>destinationDir: the path of the destination directory, 
    defaults to current directory</li>
<li>batchSize: the number of records per collection file to be generated  
    (0 for unlimited batch size),  
    defaults to 0</li>
</ul>
The batches will be named b[batchNumber].xml

For example:

```  
perl MiJ2XML.pl myMARC.json myDir  100  
```  
Reads myMARC.json from the current directory, use or create a subdirectory of the current directory called myDir, and write MARCXML collections in batches of 100 records or less. If there are 275 records in the source file, three batches will be created, named b1.xml, b2.xml, and b3.xml.

```  
perl MiJ2XML.pl  
```  
Reads meta.json from the current directory and generate a single b1.xml file in the current directory.

## dependencies:
<ul>
<li>attributes</li>
<li>AutoLoader</li>
<li>base</li>
<li>bytes</li>
<li>POSIX::autosplit.ix</li>
<li>POSIX::load_imports.al</li>
<li>Carp</li>
<li>charnames</li>
<li>Class::Accessor</li>
<li>common::sense</li>
<li>Config</li>
<li>constant</li>
<li>Data::Dumper</li>
<li>DynaLoader</li>
<li>Encode</li>
<li>Encode::Alias</li>
<li>Encode::Config</li>
<li>Encode::Encoding</li>
<li>ex::monkeypatched</li>
<li>Exporter</li>
<li>Exporter::Heavy</li>
<li>Fcntl</li>
<li>File::Spec</li>
<li>File::Spec::Unix</li>
<li>File::Spec::Win32</li>
<li>GDBM_File</li>
<li>integer</li>
<li>IO</li>
<li>IO::File</li>
<li>IO::Handle</li>
<li>IO::Seekable</li>
<li>JSON</li>
<li>JSON::XS</li>
<li>List::Util</li>
<li>MARC::Batch</li>
<li>MARC::Charset</li>
<li>MARC::Charset::Code</li>
<li>MARC::Charset::Constants</li>
<li>MARC::Charset::Table</li>
<li>MARC::Field</li>
<li>MARC::File</li>
<li>MARC::File::MiJ</li>
<li>MARC::File::XML</li>
<li>MARC::Record</li>
<li>MARC::Record::MiJ</li>
<li>overload</li>
<li>POSIX</li>
<li>SelectSaver</li>
<li>Storable</li>
<li>strict</li>
<li>Sub::Name</li>
<li>Symbol</li>
<li>Tie::Hash</li>
<li>Unicode::Normalize</li>
<li>utf8</li>
<li>vars</li>
<li>warnings</li>
<li>warnings::register</li>
<li>XML::LibXML</li>
<li>XML::LibXML::Boolean</li>
<li>XML::LibXML::Error</li>
<li>XML::LibXML::Literal</li>
<li>XML::LibXML::NodeList</li>
<li>XML::LibXML::Number</li>
<li>XML::LibXML::XPathContext</li>
<li>XML::SAX::Exception</li>
<li>XSLoader</li>
</ul>
