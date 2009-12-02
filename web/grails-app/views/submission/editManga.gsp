<html>
  <head>
    <meta name="layout" content="main">
    <style>
      .tab{
        border: 2px solid #b95e02; 
        padding: 2px;
        vertical-align: middle;
      }
      .volume{
        width: 40px;
      }
      .main{
        padding: 10px;      
        vertical-align: top;
      }
      legend{
        font-weight: bold;
        color: #904800;
      }
    </style>
   <g:javascript library="prototype"/>
    <g:javascript>
      var jQ = $;
     </g:javascript>
  </head>
  <body>

  <content tag="leftContent">
    <h1> Manga edit | ${m.name} | id=${m.id}</h1>
    <g:form action="saveManga" params="[id: m.id]">
      <table class="main">
        <tr><td class="main">
          <fieldset class="tab">
            <legend>Names</legend>
            <table>

              <tr><td>Russian:</td> <td><g:textField name="name" value="${m.name}"/></td></tr>
              <tr><td>English:</td> <td><g:textField name="engName" value="${m.engName}"/></td></tr>
              <tr><td>Japanese:</td> <td><g:textField name="jpName" value="${m.jpName}"/></td></tr>
            </table>
          </fieldset>
        </td>
          <td class="main">

            <fieldset class="tab">
              <legend>Amount</legend>
              <table>
                <tr><td>
                  <g:checkBox name="completed" value="${m.completed}"/> Completed
                  <g:checkBox name="translationCompleted" value="${m.translationCompleted}"/> Translated
                </td></tr>
                <tr><td>
                  Vol count: <g:textField name="volumeCount" class="volume" value="${m.volumeCount}"/>
                  <g:checkBox name="single" value="${m.single}"/> Single
                </td>
                </tr>
                <tr>
                <td>
                  <g:checkBox name="mature" value="${m.mature}"/> <b>Mature</b>
                </td>
              </tr>
              </table>
            </fieldset>
          </td>
        </tr>
      </table>
      <table class="main"><tr><td>
        <fieldset class="tab">
          <legend>Description</legend>
          <fckeditor:editor
                  name="description"
                  width="630"
                  height="400"
                  toolbar="Standard"
                  fileBrowser="default">
            ${m.description}
          </fckeditor:editor>
        </fieldset>
        <br/>
        <button type="submit" class="submit">Submit</button>
        <br/><br/>
        <fieldset class="tab">
          <legend>Chapters title</legend>
          [volume.]chapter%title<br>
          <g:textArea name="chaptersNames" value="" rows="15" cols="75"/>
        </fieldset>
      </td></tr></table>
      <button class="submit" type="submit">Submit</button>
  </content>
  <content tag="rightContent">
    <h1>Picture</h1>  
    <fckeditor:editor
                  name="picture"
                  width="250"
                  height="400"
                  toolbar="Multimedia"
                  fileBrowser="default">
            ${m.picture}
          </fckeditor:editor>
    </g:form>
    <g:javascript>

//FCKConfig.ToolbarSets["Pictures"] = [
//['Source','DocProps','-','Save','Preview'],
//['Cut','Copy','Paste'],
//['Undo','Redo','-','SelectAll'],
//['Image','Flash']] ;


    </g:javascript>
  <br/>
  <br/>
      <g:render template="/admin/trans/translatorsWidget"/>
    <br/>
  <br/>
      <g:render template="/admin/genres/genresWidget"/>
  </content>
  </body>
</html>
